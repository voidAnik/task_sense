import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

abstract class TaskListRepository {
  Future<Either<Failure, int>> insertTaskList(TaskListModel taskList);
  Future<Either<Failure, List<TaskListWithCountModel>>> getAllTaskLists();
  Future<Either<Failure, void>> updateTaskList(TaskListModel taskList);
  Future<Either<Failure, void>> deleteTaskList(int id);
}
