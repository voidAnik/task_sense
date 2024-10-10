import 'package:sqflite/sqflite.dart';
import 'package:task_sense/core/database/database_constants.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';

class TaskDao {
  final Database _db;

  TaskDao(this._db);

  Future<void> insertTask(TaskModel task) async {
    await _db.insert(
      tasksTable,
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(TaskModel task) async {
    await _db.update(
      tasksTable,
      task.toJson(),
      where: '$taskColumnId = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await _db.delete(
      tasksTable,
      where: '$taskColumnId = ?',
      whereArgs: [id],
    );
  }

  /// Fetch all tasks belonging to a specific task list.
  Future<List<TaskModel>> getAllTasks(int taskListId) async {
    final result = await _db.query(
      tasksTable,
      where: '$taskListColumnId = ?',
      whereArgs: [taskListId],
    );
    return result.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<TaskModel?> getTaskById(int id) async {
    final result = await _db.query(
      tasksTable,
      where: '$taskColumnId = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return TaskModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<TaskModel>> getTasksByStatus(
      int taskListId, bool isCompleted) async {
    final result = await _db.query(
      tasksTable,
      where: '$taskListColumnId = ? AND $taskColumnIsCompleted = ?',
      whereArgs: [taskListId, isCompleted ? 1 : 0],
    );
    return result.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<int> countIncompleteTasks() async {
    final result = await _db.rawQuery('''
      SELECT COUNT(*) as incompleteCount 
      FROM $tasksTable 
      WHERE $taskColumnIsCompleted = 0
    ''');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> countCompleteTasks() async {
    final result = await _db.rawQuery('''
      SELECT COUNT(*) as completeCount 
      FROM $tasksTable 
      WHERE $taskColumnIsCompleted = 1
    ''');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
