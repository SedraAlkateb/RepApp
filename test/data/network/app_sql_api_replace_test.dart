// اختبار الاستبدال الذرّي للبيانات الأساسية أثناء المزامنة (حذف + إدخال بمعاملة واحدة).
import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _Accessor implements DatabaseAccessor {
  _Accessor(this.db);
  final Database db;
  @override
  Future<Database> get database async => db;
}

Future<Database> _openDb() async {
  return databaseFactoryFfi.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      version: 1,
      onConfigure: (db) async => db.execute('PRAGMA foreign_keys = ON'),
      onCreate: (db, _) async {
        await db.execute(
            'CREATE TABLE specialization (id INTEGER PRIMARY KEY, title TEXT NOT NULL, flag INTEGER NOT NULL, sumDoctor INTEGER DEFAULT 0, sumHospital INTEGER DEFAULT 0, sumBrandHospital INTEGER DEFAULT 0)');
        await db.execute(
            'CREATE TABLE place (placeId INTEGER PRIMARY KEY, title TEXT NOT NULL, totalVisit INTEGER NOT NULL DEFAULT 0)');
        await db.execute(
            'CREATE TABLE doctor (id INTEGER PRIMARY KEY, title TEXT NOT NULL, placeId INTEGER NOT NULL, address TEXT NOT NULL, placeTitle TEXT NOT NULL, visits INTEGER NOT NULL, spTitle TEXT NOT NULL, workHours TEXT NOT NULL, note TEXT NOT NULL, rate TEXT NOT NULL, spId INTEGER NOT NULL)');
        await db.execute(
            'CREATE TABLE hospital (id INTEGER PRIMARY KEY, title TEXT NOT NULL, address TEXT NOT NULL, placeId INTEGER NOT NULL, note TEXT NOT NULL, placeTitle TEXT NOT NULL)');
        await db.execute(
            'CREATE TABLE brand (id INTEGER PRIMARY KEY, title TEXT NOT NULL, phTitle TEXT NOT NULL, falg INTEGER NOT NULL, sampleCoast INTEGER NOT NULL, features TEXT, generalCoast TEXT, phCoast TEXT)');
        await db.execute(
            'CREATE TABLE hospitalSp (id INTEGER PRIMARY KEY, hospitalId INTEGER NOT NULL, spId INTEGER NOT NULL, totalDocs INTEGER NOT NULL, rate TEXT NOT NULL, visit INTEGER NOT NULL, flag INTEGER NOT NULL DEFAULT 0)');
        await db.execute(
            'CREATE TABLE brandSp (id INTEGER PRIMARY KEY, spId INTEGER NOT NULL, brandId INTEGER NOT NULL, brandType TEXT NOT NULL)');
        await db.execute(
            'CREATE TABLE planBrand (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE pharmacy (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE visit_doctor (id INTEGER PRIMARY KEY, data TEXT NOT NULL, kaswn TEXT, science TEXT, additaion TEXT, doctorId INTEGER NOT NULL, flag INTEGER NOT NULL DEFAULT 0, target TEXT)');
        await db.execute(
            'CREATE TABLE visit_hospital (id INTEGER PRIMARY KEY, data TEXT NOT NULL, flag INTEGER NOT NULL DEFAULT 0, marker TEXT)');
        await db.execute(
            'CREATE TABLE visit_pharmacy (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE visit_brand_pharmacy (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE visit_brand_doctor (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE visit_brand_hospital (id INTEGER PRIMARY KEY, marker TEXT)');
        await db.execute(
            'CREATE TABLE exception_table (id INTEGER PRIMARY KEY, marker TEXT)');
      },
    ),
  );
}

Future<String> _sync(
  AppSqlApi api, {
  required List<PlaceModel> places,
  List<PlanBrandModel>? planBrands,
  bool replace = true,
  bool keepPlan = false,
}) {
  return api.asyncData(
    [],
    places,
    [],
    [],
    [],
    [],
    [],
    VisitHospitalBase([], []),
    VisitDoctorBase([], []),
    planBrands: planBrands,
    replaceExisting: replace,
    keepPlanBrand: keepPlan,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  late Database db;
  late AppSqlApi api;

  setUp(() async {
    db = await _openDb();
    api = AppSqlApi(_Accessor(db));
    await db.insert('place', {'placeId': 1, 'title': 'قديم', 'totalVisit': 0});
    await db.insert('planBrand', {'id': 1, 'marker': 'saved-offline-plan'});
    await db.insert('exception_table', {'id': 1, 'marker': 'x'});
  });

  tearDown(() async => db.close());

  test('الاستبدال يحذف القديم ويدخل الجديد بمعاملة واحدة', () async {
    final result = await _sync(api, places: [PlaceModel(7, 'جديد', 2)]);

    expect(result, '');
    final rows = await db.query('place');
    expect(rows.map((r) => r['placeId']), [7]);
    expect(await db.query('exception_table'), isEmpty);
  });

  test('خطة المندوب المحفوظة محلياً (keepPlanBrand) لا تُحذف', () async {
    await _sync(api, places: [PlaceModel(7, 'جديد', 2)], keepPlan: true);

    final plan = await db.query('planBrand');
    expect(plan.single['marker'], 'saved-offline-plan');
  });

  test('بدون keepPlanBrand تُحذف planBrand القديمة', () async {
    await _sync(api, places: [PlaceModel(7, 'جديد', 2)], keepPlan: false);

    expect(await db.query('planBrand'), isEmpty);
  });

  test('فشل الإدخال يتراجع عن الحذف فتبقى البيانات القديمة سليمة', () async {
    // مفتاحان متطابقان => فشل الإدخال داخل المعاملة.
    final result = await _sync(
      api,
      places: [PlaceModel(9, 'أ', 1), PlaceModel(9, 'ب', 1)],
    );

    expect(result, isNotEmpty);
    final rows = await db.query('place');
    expect(rows.single['title'], 'قديم');
    expect((await db.query('planBrand')).single['marker'], 'saved-offline-plan');
    expect(await db.query('exception_table'), hasLength(1));
  });

  test('بدون replaceExisting السلوك القديم: لا حذف', () async {
    await _sync(api, places: [PlaceModel(7, 'جديد', 2)], replace: false);

    expect((await db.query('place')).map((r) => r['placeId']), [1, 7]);
  });
}
