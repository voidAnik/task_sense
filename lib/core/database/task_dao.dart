import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:task_sense/core/database/database_constants.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';

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
      where: '$taskColumnTaskListId = ?',
      whereArgs: [taskListId],
    );
    log('getting tasks for id: $taskListId result: $result');
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

  Future<TaskCount> countTasks() async {
    final result = await _db.rawQuery('''
    SELECT 
      SUM(CASE WHEN $taskColumnIsCompleted = 0 THEN 1 ELSE 0 END) AS incompleteCount,
      SUM(CASE WHEN $taskColumnIsCompleted = 1 THEN 1 ELSE 0 END) AS completeCount
    FROM $tasksTable
  ''');

    final data = result.isNotEmpty ? result.first : {};

    return TaskCount(
      completeCount: data['completeCount'] ?? 0,
      incompleteCount: data['incompleteCount'] ?? 0,
    );
  }
}
