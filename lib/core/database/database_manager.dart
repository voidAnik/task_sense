import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_sense/core/database/database_constants.dart';

class DatabaseManager {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $taskListsTable (
        $taskListColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $taskListColumnTitle TEXT NOT NULL,
        $taskListColumnCreated TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tasksTable (
        $taskColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $taskColumnTaskListId INTEGER NOT NULL,
        $taskColumnTaskName TEXT NOT NULL,
        $taskColumnDueDate TEXT,
        $taskColumnNote TEXT,
        $taskColumnRemindMe INTEGER NOT NULL,
        $taskColumnIsCompleted INTEGER NOT NULL,
        FOREIGN KEY ($taskColumnTaskListId) REFERENCES $taskListsTable($taskListColumnId) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
