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

  Future<void> deleteTask(int id) async {
    await _db.delete(
      tasksTable,
      where: '$taskColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskModel>> getAllTasks(int taskListId) async {
    final result = await _db.query(
      tasksTable,
      where: '$taskColumnTaskListId = ?',
      whereArgs: [taskListId],
    );
    log('getting tasks for id: $taskListId result: $result');
    return result.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<List<TaskModel>> getTasksDueToday() async {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = todayStart.add(const Duration(days: 1));

    final result = await _db.query(
      tasksTable,
      where:
          '$taskColumnDueDate >= ? AND $taskColumnDueDate < ?AND $taskColumnIsCompleted = 0',
      whereArgs: [todayStart.toIso8601String(), todayEnd.toIso8601String()],
    );

    log('Tasks due today: $result');
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
