import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';

class GetTasks extends StreamUseCase<List<TaskModel>, int> {
  final TaskRepository _repository;
  GetTasks(this._repository);

  @override
  Stream<List<TaskModel>> call({required int params}) {
    return _repository.getTaskStream(params);
  }

  void closeStream() {
    _repository.closeStream();
  }
}
