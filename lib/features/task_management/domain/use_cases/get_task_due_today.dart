import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class GetTaskDueToday extends UseCase<List<TaskModel>, NoParams> {
  final TaskRepository _repository;

  GetTaskDueToday(this._repository);

  @override
  Future<Either<Failure, List<TaskModel>>> call({required NoParams params}) {
    return _repository.getTodayTasks();
  }
}
