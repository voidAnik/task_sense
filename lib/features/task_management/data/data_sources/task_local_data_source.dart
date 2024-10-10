import 'package:task_sense/core/database/task_dao.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<void> insertTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks(int taskListId);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int id);

  Future<int> countIncompleteTasks();
  Future<int> countCompleteTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final TaskDao _dao;

  TaskLocalDataSourceImpl(this._dao);

  @override
  Future<void> insertTask(TaskModel task) async {
    try {
      await _dao.insertTask(task);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks(int taskListId) async {
    try {
      return await _dao.getAllTasks(taskListId);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await _dao.updateTask(task);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    try {
      await _dao.deleteTask(id);
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<int> countIncompleteTasks() async {
    try {
      return await _dao.countIncompleteTasks();
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }

  @override
  Future<int> countCompleteTasks() async {
    try {
      return await _dao.countCompleteTasks();
    } catch (e) {
      throw DatabaseException(error: e.toString());
    }
  }
}
