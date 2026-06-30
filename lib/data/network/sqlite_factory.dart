import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart';
// تغيير الاستيراد إلى sqlcipher
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DatabaseHelper {
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

  // دالة مخصصة للحصول على مفتاح التشفير أو إنشائه إن لم يكن موجوداً
  Future<String> _getOrCreateEncryptionKey() async {
    const keyName = 'db_encryption_key';

    String? storedKey = await _secureStorage.read(key: keyName);

    if (storedKey == null) {
      // إذا لم يكن موجوداً، قم بتوليد مفتاح عشوائي قوي
      var random = Random.secure();
      var values = List<int>.generate(32, (i) => random.nextInt(256));
      String newKey = base64Url.encode(values);

      // ✅ والتصحيح هنا أيضاً عند الكتابة
      await _secureStorage.write(key: keyName, value: newKey);
      return newKey;
    }

    return storedKey;
  }
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task_database1.db');

    // جلب المفتاح السري الآمن
    final encryptionKey = await _getOrCreateEncryptionKey();

    return await openDatabase(
      path,
      version: 5,
      password: encryptionKey, // 👈 هنا يكمن السحر: يتم تشفير البيانات بالكامل بـ AES-256
      onCreate: _onCreate,
      onOpen: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE rep (
    token  TEXT NOT NULL,
    repId INTEGER NOT NULL,
    cityId INTEGER NOT NULL,
    cityTitle TEXT ,
    otherPlanId INTEGER ,
    activePlanId INTEGER ,
    otherStatus INTEGER NOT NULL,
    flag INTEGER NOT NULL DEFAULT 0,
    flag1 INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    repType TEXT ,
    percentage INTEGER NOT NULL,
    samplesCount INTEGER NOT NULL,
    recipesCount INTEGER NOT NULL DEFAULT 0,
    isLogin INTEGER NOT NULL DEFAULT 0,
    endDate TEXT ,
    startDate TEXT ,
    otherStartDate TEXT ,
    otherEndDate TEXT 
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
    title TEXT NOT NULL
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
     sampleCoast INTEGER NOT NULL
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
