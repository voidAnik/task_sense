import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> insertTask(TaskModel task);
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int taskListId);
  Future<Either<Failure, void>> updateTask(TaskModel task);
  Future<Either<Failure, void>> deleteTask(int id);
}
