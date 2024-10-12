import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';

abstract class TaskRepository {
  Future<Either<Failure, void>> insertTask(TaskModel task);
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int taskListId);
  Future<Either<Failure, void>> deleteTask(int id, int listId);
  Future<Either<Failure, TaskCount>> countTasks();
  Stream<List<TaskModel>> getTaskStream(int taskListId);
  void closeStream();
}
