import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class DeleteTask extends UseCase<void, DeleteParams> {
  final TaskRepository _repository;

  DeleteTask(this._repository);

  @override
  Future<Either<Failure, void>> call({required DeleteParams params}) {
    return _repository.deleteTask(params.taskId, params.taskListId);
  }
}

class DeleteParams {
  final int taskId;
  final int taskListId;

  DeleteParams(this.taskId, this.taskListId);
}
