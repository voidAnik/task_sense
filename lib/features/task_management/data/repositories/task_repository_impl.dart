import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _dataSource;
  StreamController<List<TaskModel>>? _taskStreamController;

  TaskRepositoryImpl(this._dataSource);

  @override
  Stream<List<TaskModel>> getTaskStream(int taskListId) {
    _taskStreamController ??= StreamController<List<TaskModel>>.broadcast();
    _emitTaskList(taskListId);
    return _taskStreamController!.stream;
  }

  Future<void> _emitTaskList(int taskListId) async {
    final tasks = await _dataSource.getAllTasks(taskListId);
    _taskStreamController!.add(tasks);
  }

  @override
  Future<Either<Failure, void>> insertTask(TaskModel task) async {
    try {
      await _dataSource.insertTask(task);
      _emitTaskList(task.taskListId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int taskListId) async {
    try {
      final tasks = await _dataSource.getAllTasks(taskListId);
      return Right(tasks);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskModel task) async {
    try {
      await _dataSource.updateTask(task);
      _emitTaskList(task.taskListId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id, int listId) async {
    try {
      await _dataSource.deleteTask(id);
      _emitTaskList(listId);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, TaskCount>> countTasks() async {
    try {
      final count = await _dataSource.countTasks();
      return Right(count);
    } catch (e) {
      return Left(DatabaseFailure(error: e.toString()));
    }
  }

  @override
  void closeStream() {
    if (_taskStreamController != null) {
      _taskStreamController!.close();
      _taskStreamController = null;
    }
  }
}
