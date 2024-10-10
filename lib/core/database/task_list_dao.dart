import 'package:sqflite/sqflite.dart';
import 'package:task_sense/core/database/database_constants.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';

class TaskListDao {
  final Database _db;

  TaskListDao(this._db);

  Future<void> insertTaskList(TaskListModel taskList) async {
    await _db.insert(
      taskListsTable,
      taskList.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskListModel>> getAllTaskLists() async {
    final result = await _db.query(taskListsTable);
    return result.map((e) => TaskListModel.fromJson(e)).toList();
  }

  Future<void> updateTaskList(TaskListModel taskList) async {
    await _db.update(
      taskListsTable,
      taskList.toJson(),
      where: '$taskListColumnId = ?',
      whereArgs: [taskList.id],
    );
  }

  Future<void> deleteTaskList(int id) async {
    await _db.delete(
      taskListsTable,
      where: '$taskListColumnId = ?',
      whereArgs: [id],
    );
  }
}
