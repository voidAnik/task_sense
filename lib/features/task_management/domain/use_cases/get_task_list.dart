import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_list_repository.dart';

class GetTaskList extends UseCase<List<TaskListWithCountModel>, NoParams> {
  final TaskListRepository _repository;

  GetTaskList(this._repository);

  @override
  Future<Either<Failure, List<TaskListWithCountModel>>> call(
      {required NoParams params}) {
    return _repository.getAllTaskLists();
  }
}
