import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL
      )
    ''');
  }

  // دالة الإضافة
  Future<int> insertQuote(String content) async {
    final db = await instance.database;
    return await db.insert('quotes', {'content': content});
  }

  // دالة جلب البيانات
  Future<List<String>> getAllQuotes() async {
    final db = await instance.database;
    final result = await db.query('quotes');
    return result.map((json) => json['content'] as String).toList();
  }
}
