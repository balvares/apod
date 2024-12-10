import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConfig {
  static final DbConfig instance = DbConfig._internal();
  static Database? _database;

  DbConfig._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'apod.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE apod (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        title TEXT NOT NULL,
        explanation TEXT NOT NULL,
        url TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAPOD(Map<String, dynamic> apod) async {
    final db = await database;
    return await db.insert('apod', apod,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future getAPOD({
    required String date,
  }) async {
    final db = await database;
    return await db.query(
      'apod',
      where: 'DATE = ?',
      whereArgs: [date],
    );
  }

  Future<List<Map<String, dynamic>>> getAPODList({
    required String startDate,
    required String endDate,
  }) async {
    final db = await database;
    return await db.query(
      'apod',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [
        startDate,
        endDate,
      ],
      orderBy: 'date ASC',
    );
  }

  Future<int> deleteAllAPODs() async {
    final db = await database;
    return await db.delete('apod');
  }
}
