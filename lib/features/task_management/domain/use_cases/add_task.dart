import 'package:dartz/dartz.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class AddTask extends UseCase<void, TaskModel> {
  final TaskRepository _repository;

  AddTask(this._repository);

  @override
  Future<Either<Failure, void>> call({required TaskModel params}) {
    return _repository.insertTask(params);
  }
}
