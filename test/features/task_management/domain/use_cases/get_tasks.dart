import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_tasks.dart';

import 'repository_mocks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late GetTasks useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTasks(mockTaskRepository);
  });

  final tTaskModel = TaskModel(
    id: 1,
    taskListId: 1,
    taskName: 'Test Task 1',
    dueDate: DateTime.now(),
    note: 'Test Note 1',
    remindMe: true,
    isCompleted: false,
    isMarked: false,
  );
  final tTaskModelList = [tTaskModel, tTaskModel];

  group('GetTasksUseCase', () {
    test('should return a stream of TaskModel when calling getTaskStream',
        () async {
      // Arrange
      when(mockTaskRepository.getTaskStream(any))
          .thenAnswer((_) => Stream.value(tTaskModelList));

      // Act
      final resultStream = useCase(params: 1);

      // Assert
      expectLater(resultStream, emits(tTaskModelList));
      verify(mockTaskRepository.getTaskStream(1)).called(1);
    });

    test('should call closeStream when closeStream is invoked', () {
      // Act
      useCase.closeStream();

      // Assert
      verify(mockTaskRepository.closeStream()).called(1);
    });
  });
}
