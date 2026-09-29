import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:domina_app/app/logger/app_logger.dart';
import 'package:domina_app/crashlytics/crashlytics_service.dart';

abstract class DatabaseAccessor {
  Future<Database> get database;
}

final _log = AppLogger.get('DatabaseHelper');

// سجل تشخيصي يصل لـ Crashlytics عن بُعد (بالإضافة لسجل محلي وقت التطوير)،
// حتى نعرف بالأرقام أي مسار سلكه كل مستخدم فعلياً عند فتح القاعدة، بدل
// انتظار بلاغات يدوية. يُكتب بصمت إن لم يكن Crashlytics مسجّلاً بعد (مثلاً
// في اختبارات الوحدة).
void _logDiagnostic(String message) {
  _log.info(message);
  try {
    GetIt.instance<CrashlyticsService>().log('[DatabaseHelper] $message');
  } catch (_) {}
}

class DatabaseHelper implements DatabaseAccessor {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // تعريف التخزين الآمن للجهاز
  final _secureStorage = const FlutterSecureStorage();

  factory DatabaseHelper() {
    return _instance;
  }
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static const _keyName = 'db_encryption_key';

  // دالة مخصصة للحصول على مفتاح التشفير أو إنشائه إن لم يكن موجوداً
  Future<String> _getOrCreateEncryptionKey(String dbPath) async {
    String? storedKey = await _secureStorage.read(key: _keyName);

    if (storedKey == null) {
      if (await File(dbPath).exists()) {
        _logDiagnostic(
            'DB key missing in secure storage while $dbPath exists; checking if it is a legacy pre-encryption database');

        // قد يكون الملف قاعدة بيانات قديمة من نسخة سابقة للتطبيق لم تكن تدعم
        // التشفير أصلاً (لا يوجد لها مفتاح من الأساس)، وليس بالضرورة قاعدة
        // مشفّرة فقد مفتاحها. نتحقق فعلياً قبل الحكم بالفشل.
        final migratedKey = await _migrateLegacyPlaintextDatabase(dbPath);
        if (migratedKey != null) {
          _logDiagnostic(
              'Legacy plaintext database migrated to encrypted successfully; original kept as backup');
          return migratedKey;
        }

        // الملف موجود، وليس قابلاً للفتح بدون كلمة سر (أي أنه فعلاً مشفّر)،
        // لكن مفتاحه غير موجود في التخزين الآمن (استعادة نسخة احتياطية أو فشل
        // مؤقت في Keystore/Keychain): لا نولّد مفتاحاً جديداً ولا نستبدل
        // القديم، لأن ذلك يجعل بيانات المندوب (زياراته غير المرسلة) غير قابلة
        // للاسترجاع نهائياً.
        _logDiagnostic(
            'DB file is not openable without a password; treating as a genuinely encrypted database with a lost key');
        throw StateError(
            'Encrypted database exists but its key is unavailable in secure storage');
      }
      // إذا لم يكن موجوداً، قم بتوليد مفتاح عشوائي قوي
      var random = Random.secure();
      var values = List<int>.generate(32, (i) => random.nextInt(256));
      String newKey = base64Url.encode(values);

      // ✅ والتصحيح هنا أيضاً عند الكتابة
      await _secureStorage.write(key: _keyName, value: newKey);
      return newKey;
    }

    return storedKey;
  }

  // يحاول فتح [dbPath] بدون كلمة سر؛ إن نجح فهذه قاعدة بيانات قديمة من قبل
  // إضافة التشفير، فنولّد لها مفتاحاً جديداً ونشفّرها في مكانها عبر
  // sqlcipher_export دون فقدان أي بيانات. يعيد null إن كان الملف مشفّراً
  // فعلاً (غير قابل للفتح بدون كلمة سر)، فيسلك الاستدعاء المسار القديم
  // (رمي الخطأ بدل تخمين أو حذف أي شيء).
  //
  // احتياطات: (1) لا نحذف الملف الأصلي أبداً — نُبقيه إلى جانب النسخة
  // المشفّرة الجديدة تحت اسم "...pre_encryption_backup" حتى لو نجح كل شيء،
  // (2) نتحقق أن عدد صفوف كل جدول في النسخة الجديدة يطابق الأصل قبل اعتمادها،
  // وإلا نتوقف دون لمس الملف الأصلي إطلاقاً.
  Future<String?> _migrateLegacyPlaintextDatabase(String dbPath) async {
    Database? plainDb;
    try {
      plainDb = await openDatabase(dbPath, readOnly: false);
      await plainDb.rawQuery('SELECT count(*) FROM sqlite_master');
    } catch (_) {
      await plainDb?.close();
      return null;
    }

    final beforeCounts = await _tableRowCounts(plainDb);

    var random = Random.secure();
    var values = List<int>.generate(32, (i) => random.nextInt(256));
    final newKey = base64Url.encode(values);

    final tmpEncryptedPath = '$dbPath.encrypting_tmp';
    final tmpFile = File(tmpEncryptedPath);
    if (await tmpFile.exists()) {
      await tmpFile.delete();
    }

    try {
      await plainDb.execute(
          "ATTACH DATABASE '$tmpEncryptedPath' AS encrypted KEY '$newKey'");
      await plainDb.execute("SELECT sqlcipher_export('encrypted')");
      await plainDb.execute('DETACH DATABASE encrypted');
      await plainDb.close();
      plainDb = null;

      // تحقّق من سلامة النسخة المشفّرة قبل أي تعديل على الملف الأصلي.
      final encryptedDb =
          await openDatabase(tmpEncryptedPath, password: newKey);
      final afterCounts = await _tableRowCounts(encryptedDb);
      await encryptedDb.close();

      if (!_sameRowCounts(beforeCounts, afterCounts)) {
        _logDiagnostic(
            'sqlcipher_export row count mismatch, aborting migration without touching the original file: before=$beforeCounts after=$afterCounts');
        throw StateError(
            'sqlcipher_export row count mismatch: before=$beforeCounts after=$afterCounts');
      }

      // لا حذف نهائياً: الأصل يبقى كنسخة احتياطية دائمة على الجهاز.
      final backupPath =
          await _uniqueBackupPath('$dbPath.pre_encryption_backup');
      await File(dbPath).rename(backupPath);
      await tmpFile.rename(dbPath);

      await _secureStorage.write(key: _keyName, value: newKey);
      return newKey;
    } catch (e) {
      await plainDb?.close();
      if (await tmpFile.exists()) {
        await tmpFile.delete();
      }
      rethrow;
    }
  }

  Future<String> _uniqueBackupPath(String basePath) async {
    if (!await File(basePath).exists()) return basePath;
    var i = 1;
    while (await File('$basePath.$i').exists()) {
      i++;
    }
    return '$basePath.$i';
  }

  Future<Map<String, int>> _tableRowCounts(Database db) async {
    final tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
    final counts = <String, int>{};
    for (final row in tables) {
      final name = row['name'] as String;
      final result = await db.rawQuery('SELECT COUNT(*) AS c FROM "$name"');
      counts[name] = (result.first['c'] as int?) ?? 0;
    }
    return counts;
  }

  bool _sameRowCounts(Map<String, int> before, Map<String, int> after) {
    for (final entry in before.entries) {
      if (after[entry.key] != entry.value) return false;
    }
    return true;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task_database1.db');

    final encryptionKey = await _getOrCreateEncryptionKey(path);

    return await openDatabase(
      path,
      version: 8, // تم رفع الإصدار إلى 8
      password: encryptionKey,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 6) {
      await db.execute(
        'ALTER TABLE place ADD COLUMN totalVisit INTEGER NOT NULL DEFAULT 0;',
      );
      await db.execute(
        'ALTER TABLE rep ADD COLUMN totalVisitDoc INTEGER NOT NULL DEFAULT 0;',
      );
      await db.execute(
        'ALTER TABLE rep ADD COLUMN totalVisitHos INTEGER NOT NULL DEFAULT 0;',
      );
    }

    // الترقية إلى الإصدار 7 (إضافة حقول جدول brand)
    if (oldVersion < 7) {
      await db.execute(
        'ALTER TABLE brand ADD COLUMN features TEXT;',
      );
      await db.execute(
        'ALTER TABLE brand ADD COLUMN generalCoast TEXT;',
      );
      await db.execute(
        'ALTER TABLE brand ADD COLUMN phCoast TEXT;',
      );
    }

    // الترقية إلى الإصدار 8 (إضافة groupTitle إلى جدول rep)
    if (oldVersion < 8) {
      await db.execute(
        'ALTER TABLE rep ADD COLUMN groupTitle TEXT;',
      );
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE rep (
    token TEXT NOT NULL,
    repId INTEGER NOT NULL,
    cityId INTEGER NOT NULL,
    cityTitle TEXT,
    otherPlanId INTEGER,
    activePlanId INTEGER,
    otherStatus INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    flag1 INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    repType TEXT,
    percentage INTEGER NOT NULL,
    samplesCount INTEGER NOT NULL,
    recipesCount INTEGER NOT NULL DEFAULT 0,
    isLogin INTEGER NOT NULL DEFAULT 0,
    endDate TEXT,
    startDate TEXT,
    otherStartDate TEXT,
    otherEndDate TEXT,
    totalReci INTEGER NOT NULL DEFAULT 0,
    usedReci INTEGER NOT NULL DEFAULT 0,
    remainReci INTEGER NOT NULL DEFAULT 0,
    totalVisitDoc INTEGER NOT NULL DEFAULT 0, 
    totalVisitHos INTEGER NOT NULL DEFAULT 0,
    groupTitle TEXT
  );
  ''');
    await db.execute('''
  CREATE TABLE specialization (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    flag INTEGER NOT NULL,
    sumDoctor INTEGER DEFAULT 0,
    sumHospital INTEGER DEFAULT 0,
    sumBrandHospital INTEGER DEFAULT 0
  );
''');

    await db.execute('''
      CREATE TABLE place (
    placeId INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    totalVisit INTEGER NOT NULL DEFAULT 0 -- 👈 أضف الحقل هنا أيضاً
    );
    ''');
    await db.execute('''
      CREATE TABLE pharmacy (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(placeId)
    );
    ''');

    await db.execute('''
     CREATE TABLE doctor (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    placeTitle TEXT NOT NULL, 
    visits INTEGER NOT NULL,
    spTitle TEXT NOT NULL,
    workHours TEXT NOT NULL,
    note TEXT NOT NULL,
    rate TEXT NOT NULL,
    spId INTEGER NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(placeId)
);
 ''');
    await db.execute('''
    CREATE TABLE hospital (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    note TEXT NOT NULL,
    placeTitle TEXT NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(placeId)
    );
    ''');
    await db.execute('''
  CREATE TABLE brand (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    phTitle TEXT NOT NULL,
    falg INTEGER NOT NULL,
    sampleCoast INTEGER NOT NULL,
    features TEXT,
    generalCoast TEXT,
    phCoast TEXT
  );
''');
    await db.execute('''
        CREATE TABLE hospitalSp (
        id INTEGER PRIMARY KEY,
    hospitalId INTEGER NOT NULL,
    spId INTEGER NOT NULL,
    totalDocs INTEGER NOT NULL,
    rate TEXT NOT NULL,
    visit INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (hospitalId) REFERENCES hospital(id),
    FOREIGN KEY (spId) REFERENCES specialization(id)
    );
    ''');
    await db.execute('''
    CREATE TABLE planBrand (
    id INTEGER PRIMARY KEY,
    spId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    repPlanId INTEGER NOT NULL,
    brandType TEXT NOT NULL DEFAULT 0,
    amount TEXT NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (brandId) REFERENCES brand(id),
    FOREIGN KEY (spId) REFERENCES specialization(id)
    );
    ''');
    await db.execute('''
      CREATE TABLE brandSp (
    id INTEGER PRIMARY KEY,
    spId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    brandType TEXT NOT NULL,
    FOREIGN KEY (spId) REFERENCES specialization(id)

    );
   ''');
    await db.execute('''
     CREATE TABLE visit_doctor (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    kaswn TEXT,
    science TEXT NOT NULL,
    additaion TEXT , 
    doctorId INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    target TEXT NOT NULL,
   
    FOREIGN KEY (doctorId) REFERENCES doctor(id)
);
 ''');
    await db.execute('''
    CREATE TABLE visit_hospital(
    id INTEGER PRIMARY  KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    kaswn TEXT ,
    science TEXT NOT NULL,
    additaion TEXT , 
    hospitalSpId INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
     target TEXT NOT NULL,
    FOREIGN KEY (hospitalSpId) REFERENCES hospitalSp(id)
);
''');
    await db.execute('''
     CREATE TABLE visit_pharmacy(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    note TEXT NOT NULL,
    pharmacyId INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (pharmacyId) REFERENCES pharmacy(id))
 ''');
    await db.execute('''
     CREATE TABLE visit_brand_pharmacy(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visitId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    amount TEXT NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (visitId) REFERENCES visit_pharmacy(id),
    FOREIGN KEY (brandId) REFERENCES brand(id))
 ''');
    await db.execute('''
  CREATE TABLE visit_brand_doctor(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visitId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    amount TEXT NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (visitId) REFERENCES visit_doctor(id),
    FOREIGN KEY (brandId) REFERENCES brand(id)
  )
''');
    await db.execute('''
     CREATE TABLE visit_brand_hospital(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visitId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    amount TEXT NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (visitId) REFERENCES visit_hospital(id),
    FOREIGN KEY (brandId) REFERENCES brand(id)
    )
 ''');
    await db.execute('''
     CREATE TABLE exception_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    exception TEXT NOT NULL,
   type TEXT NOT NULL,
   createDate TEXT
    )
 ''');
  }
}
