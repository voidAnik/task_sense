import 'package:task_sense/core/database/task_list_dao.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

abstract class TaskListLocalDataSource {
  Future<void> insertTaskList(TaskListModel taskList);
  Future<List<TaskListWithCountModel>> getAllTaskLists();
  Future<void> updateTaskList(TaskListModel taskList);
  Future<void> deleteTaskList(int id);
}

class TaskListLocalDataSourceImpl implements TaskListLocalDataSource {
  final TaskListDao dao;

  TaskListLocalDataSourceImpl(this.dao);

  @override
  Future<void> insertTaskList(TaskListModel taskList) async {
    try {
      await dao.insertTaskList(taskList);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<List<TaskListWithCountModel>> getAllTaskLists() async {
    try {
      return await dao.getTaskListsWithCount();
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<void> updateTaskList(TaskListModel taskList) async {
    try {
      await dao.updateTaskList(taskList);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<void> deleteTaskList(int id) async {
    try {
      await dao.deleteTaskList(id);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }
}
