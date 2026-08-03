import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:flutter_test/flutter_test.dart';

// 1. استيراد FFI مع تسمية مستعارة لتجنب تضارب الأسماء
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:sqflite_sqlcipher/sqflite.dart' hide databaseFactory;

// Imports الخاصة بمشروعك
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/domain/models/models.dart';

// Fake DatabaseHelper لتوليد قاعدة بيانات في الذاكرة FFI للاختبار
class FakeDatabaseHelper implements DatabaseHelper {
  Database? _db;

  @override
  Future<Database> get database async {
    if (_db != null) return _db!;

    // استخدام ffi.databaseFactoryFfi لفتح قاعدة البيانات مباشرة للاختبار
    _db = await ffi.databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 5,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE specialization (
              id INTEGER PRIMARY KEY, 
              title TEXT, 
              flag INTEGER, 
              sumDoctor INTEGER DEFAULT 0, 
              sumHospital INTEGER DEFAULT 0, 
              sumBrandHospital INTEGER DEFAULT 0
            );
          ''');
          await db.execute('CREATE TABLE place (placeId INTEGER PRIMARY KEY, title TEXT NOT NULL);');
          await db.execute('CREATE TABLE doctor (id INTEGER PRIMARY KEY, title TEXT NOT NULL, placeId INTEGER NOT NULL, address TEXT NOT NULL, placeTitle TEXT NOT NULL, visits INTEGER NOT NULL, spTitle TEXT NOT NULL, workHours TEXT NOT NULL, note TEXT NOT NULL, rate TEXT NOT NULL, spId INTEGER NOT NULL);');
          await db.execute('CREATE TABLE hospital (id INTEGER PRIMARY KEY, title TEXT NOT NULL, address TEXT NOT NULL, placeId INTEGER NOT NULL, note TEXT NOT NULL, placeTitle TEXT NOT NULL);');
          await db.execute('CREATE TABLE brand (id INTEGER PRIMARY KEY, title TEXT NOT NULL, phTitle TEXT NOT NULL, falg INTEGER NOT NULL, sampleCoast INTEGER NOT NULL);');
          await db.execute('CREATE TABLE hospitalSp (id INTEGER PRIMARY KEY, hospitalId INTEGER NOT NULL, spId INTEGER NOT NULL, totalDocs INTEGER NOT NULL, rate TEXT NOT NULL, visit INTEGER NOT NULL, flag INTEGER NOT NULL DEFAULT 0);');
          await db.execute('CREATE TABLE brandSp (id INTEGER PRIMARY KEY, spId INTEGER NOT NULL, brandId INTEGER NOT NULL, brandType TEXT NOT NULL);');
          await db.execute('CREATE TABLE visit_hospital (id INTEGER PRIMARY KEY, data TEXT NOT NULL, hospitalSpId INTEGER NOT NULL);');
          await db.execute('CREATE TABLE visit_doctor (id INTEGER PRIMARY KEY, data TEXT NOT NULL, doctorId INTEGER NOT NULL);');
        },
      ),
    );
    return _db!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  // 1. تهيئة الـ Test Binding لمنع خطأ Binding has not yet been initialized
  TestWidgetsFlutterBinding.ensureInitialized();

  // 2. إعداد Sqflite FFI للاختبارات محلياً بدون محاكي
  ffi.sqfliteFfiInit();
  ffi.databaseFactory = ffi.databaseFactoryFfi;

  late AppSqlApi api;
  late FakeDatabaseHelper fakeHelper;

  setUp(() async {
    fakeHelper = FakeDatabaseHelper();
    api = AppSqlApi(fakeHelper as dynamic);

    // تغليف التهيئة لتفادي أخطاء Platform Channel الخاصة بـ sqflite_sqlcipher في بيئة الاختبار
    try {
      await api.initializeDatabase();
    } catch (_) {}
  });

  tearDown(() async {
    final db = await fakeHelper.database;
    await db.close();
  });

  test('asyncData inserts places, docs, hospitals, brands, specs and visits', () async {
    // Arrange: تجهيز كائنات البيانات الدنيا
    final places = [PlaceModel(1, 'Place 1')];
    final specs = [SpecDModel(1, 'Spec 1', 1, 0, 0, 0)];
    final doctors = [DoctorModel(1, 'Doc 1', 1, 'addr', 'placeTitle', 5, '', '', 'spTitle', 1, 'workHours')];
    final hospitals = [HospitalModel(1, 'Hos 1', 1, 'address', 'note', 'placeTitle')];
    final brands = [BrandModel(1, 'Brand 1', 'ph', 1, 10)];
    final hospitalSps = [HospitalSpModel(1, 1, 1, 10, 'rate', 2, 0)];
    final brandSps = [BrandSpModel(1, 1, 1, Type(0, "لا شيء"))];

    final visitHospital = VisitHospitalBase([], []);
    final visitDoctor = VisitDoctorBase([], []);

    // Act: إدخال البيانات عبر asyncData
    final result = await api.asyncData(
      brands,
      places,
      specs,
      doctors,
      hospitals,
      hospitalSps,
      brandSps,
      visitHospital,
      visitDoctor,
    );

    // Assert: التحقق من القيمة المرجعة
    expect(result, isA<String>());
    expect(result, equals(''));

    // التحقق من نجاح إدراج البيانات داخل قاعدة البيانات
    final db = await (api.databaseHelper.database);
    final placesRows = await db.query('place');
    expect(placesRows.length, equals(1));
    expect(placesRows.first['title'], equals('Place 1'));
  });
}