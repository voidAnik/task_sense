import 'package:sqflite/sqflite.dart';
import 'package:task_sense/core/database/database_constants.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

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

  Future<List<TaskListWithCountModel>> getTaskListsWithCount() async {
    final result = await _db.rawQuery('''
      SELECT tl.id, tl.title, tl.description, COUNT(t.id) as task_count
      FROM $taskListsTable tl
      LEFT JOIN $tasksTable t ON tl.id = t.task_list_id
      GROUP BY tl.id
    ''');

    return result.map((e) => TaskListWithCountModel.fromJson(e)).toList();
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
