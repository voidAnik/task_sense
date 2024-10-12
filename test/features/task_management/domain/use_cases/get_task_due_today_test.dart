import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_due_today.dart';

import 'repository_mocks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late GetTaskDueToday useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTaskDueToday(mockTaskRepository);
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
  final tTaskList = [tTaskModel, tTaskModel];

  group('GetTaskDueTodayUseCase', () {
    test('should return a list of TaskModel when repository call is successful',
        () async {
      // Arrange
      when(mockTaskRepository.getTodayTasks())
          .thenAnswer((_) async => Right(tTaskList));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result, Right(tTaskList));
      verify(mockTaskRepository.getTodayTasks()).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return DatabaseFailure when repository call fails', () async {
      // Arrange
      when(mockTaskRepository.getTodayTasks()).thenAnswer((_) async =>
          const Left(DatabaseFailure(error: 'Failed to get tasks due today')));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result,
          const Left(DatabaseFailure(error: 'Failed to get tasks due today')));
      verify(mockTaskRepository.getTodayTasks()).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
