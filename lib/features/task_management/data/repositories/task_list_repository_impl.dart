import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_list_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_list_repository.dart';

class TaskListRepositoryImpl implements TaskListRepository {
  final TaskListLocalDataSource _dataSource;

  TaskListRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> insertTaskList(TaskListModel taskList) async {
    try {
      await _dataSource.insertTaskList(taskList);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, List<TaskListWithCountModel>>>
      getAllTaskLists() async {
    try {
      final taskLists = await _dataSource.getAllTaskLists();
      return Right(taskLists);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskList(TaskListModel taskList) async {
    try {
      await _dataSource.updateTaskList(taskList);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskList(int id) async {
    try {
      await _dataSource.deleteTaskList(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(error: e.error));
    }
  }
}
