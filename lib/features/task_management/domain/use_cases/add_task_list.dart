import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_list_repository.dart';

class AddTaskList extends UseCase<int, TaskListModel> {
  final TaskListRepository _repository;

  AddTaskList(this._repository);

  @override
  Future<Either<Failure, int>> call({required TaskListModel params}) {
    return _repository.insertTaskList(params);
  }
}
