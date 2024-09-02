import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

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
    await db.execute('''
      CREATE TABLE representatives (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    id_plan INTEGER
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
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL
    );
    ''');
    await db.execute('''
      CREATE TABLE brand (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
     phTitle TEXT NOT NULL
    );
    ''');
    await db.execute('''
      CREATE TABLE pharmacy (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    address TEXT NOT NULL,
    placeId INTEGER NOT NULL,
    FOREIGN KEY (placeId) REFERENCES place(id)
    );
    ''');
  }



}
