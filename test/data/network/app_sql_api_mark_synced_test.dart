import 'package:domina_app/data/network/app_sql_api.dart';
import 'package:domina_app/data/network/sqlite_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// قاعدة واحدة مشتركة (على عكس FakeDatabaseHelper الذي يفتح قاعدة جديدة كل مرة).
class _SharedDb implements DatabaseAccessor {
  final Database db;
  _SharedDb(this.db);
  @override
  Future<Database> get database async => db;
}

Future<Database> _open() async {
  final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false));
  for (final t in [
    'visit_doctor',
    'visit_brand_doctor',
    'visit_hospital',
    'visit_brand_hospital'
  ]) {
    await db.execute(
        'CREATE TABLE $t (id INTEGER PRIMARY KEY, flag INTEGER NOT NULL DEFAULT 0)');
  }
  return db;
}

Future<Map<int, int>> _flags(Database db, String table) async {
  final rows = await db.query(table);
  return {for (final r in rows) r['id'] as int: r['flag'] as int};
}

void main() {
  sqfliteFfiInit();

  test('يعلّم فقط الـ ids المرفوعة والباقي يبقى flag=0', () async {
    final db = await _open();
    for (final id in [1, 2, 3]) {
      await db.insert('visit_doctor', {'id': id});
      await db.insert('visit_brand_doctor', {'id': id + 10});
    }
    final api = AppSqlApi(_SharedDb(db));

    final ok = await api.updateFlagsToDoctor(visitIds: [1, 2], brandIds: [11]);

    expect(ok, isTrue);
    expect(await _flags(db, 'visit_doctor'), {1: 1, 2: 1, 3: 0});
    expect(await _flags(db, 'visit_brand_doctor'), {11: 1, 12: 0, 13: 0});
  });

  test('قائمة فارغة لا تعلّم شيئاً', () async {
    final db = await _open();
    await db.insert('visit_hospital', {'id': 1});
    final api = AppSqlApi(_SharedDb(db));

    await api.updateFlagsToHospital(visitIds: [], brandIds: []);

    expect(await _flags(db, 'visit_hospital'), {1: 0});
  });

  test('بدون ids يعلّم الكل (السلوك القديم)', () async {
    final db = await _open();
    for (final id in [1, 2]) {
      await db.insert('visit_hospital', {'id': id});
      await db.insert('visit_brand_hospital', {'id': id});
    }
    final api = AppSqlApi(_SharedDb(db));

    await api.updateFlagsToHospital();

    expect(await _flags(db, 'visit_hospital'), {1: 1, 2: 1});
    expect(await _flags(db, 'visit_brand_hospital'), {1: 1, 2: 1});
  });

  test('أكثر من 500 id تُعالج على دفعات', () async {
    final db = await _open();
    final ids = List.generate(1200, (i) => i + 1);
    final batch = db.batch();
    for (final id in ids) {
      batch.insert('visit_doctor', {'id': id});
    }
    batch.insert('visit_doctor', {'id': 5000});
    await batch.commit(noResult: true);
    final api = AppSqlApi(_SharedDb(db));

    final ok = await api.updateFlagsToDoctor(visitIds: ids, brandIds: []);

    expect(ok, isTrue);
    final flags = await _flags(db, 'visit_doctor');
    expect(flags.entries.where((e) => e.value == 1).length, 1200);
    expect(flags[5000], 0);
  });

  test('فشل (جدول غير موجود) يرجع false ولا يعلّم شيئاً', () async {
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false));
    await db.execute(
        'CREATE TABLE visit_doctor (id INTEGER PRIMARY KEY, flag INTEGER NOT NULL DEFAULT 0)');
    await db.insert('visit_doctor', {'id': 1});
    final api = AppSqlApi(_SharedDb(db));

    final ok = await api.updateFlagsToDoctor(visitIds: [1], brandIds: [1]);

    expect(ok, isFalse);
    expect(await _flags(db, 'visit_doctor'), {1: 0}); // rollback
  });
}
