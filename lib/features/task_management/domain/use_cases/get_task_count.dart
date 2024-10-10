import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class GetTaskCount extends UseCase<TaskCount, NoParams> {
  final TaskRepository _repository;

  GetTaskCount(this._repository);

  @override
  Future<Either<Failure, TaskCount>> call({required NoParams params}) {
    return _repository.countTasks();
  }
}
