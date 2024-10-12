import 'package:task_sense/core/database/task_list_dao.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

abstract class TaskListLocalDataSource {
  Future<int> insertTaskList(TaskListModel taskList);
  Future<List<TaskListWithCountModel>> getAllTaskLists();
  Future<void> deleteTaskList(int id);
}

class TaskListLocalDataSourceImpl implements TaskListLocalDataSource {
  final TaskListDao dao;

  TaskListLocalDataSourceImpl(this.dao);

  @override
  Future<int> insertTaskList(TaskListModel taskList) async {
    try {
      return await dao.insertTaskList(taskList);
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
  Future<void> deleteTaskList(int id) async {
    try {
      await dao.deleteTaskList(id);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }
}
