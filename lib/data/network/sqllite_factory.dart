import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  Batch? batch;
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'task_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );

  }
  Future _onCreate(Database db, int version) async {

    await db.execute ('''
      CREATE TABLE rep (
    token  TEXT NOT NULL,
    repId INTEGER NOT NULL,
    planId INTEGER NOT NULL,
    name TEXT NOT NULL,
    percentage INTEGER NOT NULL,
    isLogin INTEGER NOT NULL DEFAULT 0
    );
    ''');
    await db.execute('''
      CREATE TABLE specialization (
    id INTEGER PRIMARY KEY ,
    title TEXT NOT NULL
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
      CREATE TABLE brand (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
     phTitle TEXT NOT NULL,
     falg INTEGER NOT NULL,
     sampleCoast INTEGER NOT NULL
    );
    ''');

    await db.execute('''
     CREATE TABLE doctor (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    placeTitle TEXT NOT NULL, 
    visits TEXT NOT NULL,
    spTitle TEXT NOT NULL,
    spId INTEGER NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(placeId)
);
 '''
    );
    await db.execute('''
      CREATE TABLE hospital (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    placeTitle TEXT NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(placeId)
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
    FOREIGN KEY (hospitalId) REFERENCES hospital(id),
    FOREIGN KEY (spId) REFERENCES specialization(id)

    );
    ''');
    ////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////
    await db.execute('''
     CREATE TABLE visit_doctor (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    kaswn TEXT NOT NULL,
    science TEXT NOT NULL,
    additaion TEXT NOT NULL, 
    doctorId INTEGER NOT NULL,
    FOREIGN KEY (doctorId) REFERENCES doctor(id)
);
 ''');
    await db.execute('''
     CREATE TABLE visit_hospital (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    kaswn TEXT NOT NULL,
    science TEXT NOT NULL,
    additaion TEXT NOT NULL, 
    hospitalId INTEGER NOT NULL,
    FOREIGN KEY (hospitalId) REFERENCES hospital(id)
);
 ''');
    await db.execute('''
     CREATE TABLE visit_pharmacy(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    note TEXT NOT NULL,
    pharmacyId INTEGER NOT NULL,
    FOREIGN KEY (pharmacyId) REFERENCES pharmacy(id))
 ''');
    await db.execute('''
  CREATE TABLE visit_brand_doctor(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doctorId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    quantity TEXT NOT NULL,
    FOREIGN KEY (doctorId) REFERENCES visit_doctor(id),
    FOREIGN KEY (brandId) REFERENCES brand(id)
  )
''');

    await db.execute('''
     CREATE TABLE visit_brand_pharmacy(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visitId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    quantity TEXT NOT NULL,
    FOREIGN KEY (visitId) REFERENCES visit_pharmacy(id),
    FOREIGN KEY (brandId) REFERENCES brand(id))
 ''');
    await db.execute('''
     CREATE TABLE visit_brand_hospital(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hospitalId INTEGER NOT NULL,
    brandId INTEGER NOT NULL,
    quantity TEXT NOT NULL,
    FOREIGN KEY (hospitalId) REFERENCES visit_hospital(id),
    FOREIGN KEY (brandId) REFERENCES brand(id)
    )
 ''');
  }



}
