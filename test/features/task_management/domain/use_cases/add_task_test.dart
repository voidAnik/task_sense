import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task.dart';

import 'repository_mocks_test.mocks.dart';

void main() {
  late AddTask useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = AddTask(mockTaskRepository);
  });

  final tTaskModel = TaskModel(
    id: 1,
    taskListId: 1,
    taskName: 'Test Task',
    dueDate: DateTime.now(),
    note: 'Test Note',
    remindMe: true,
    isCompleted: false,
    isMarked: false,
  );

  group('AddTaskUseCase', () {
    test('should call insertTask on the repository', () async {
      // Arrange
      when(mockTaskRepository.insertTask(any))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(params: tTaskModel);

      // Assert
      expect(result, const Right(null));
      verify(mockTaskRepository.insertTask(tTaskModel)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return DatabaseFailure when insertion fails', () async {
      // Arrange
      when(mockTaskRepository.insertTask(any)).thenAnswer(
          (_) async => const Left(DatabaseFailure(error: 'Insert Failed')));

      // Act
      final result = await useCase(params: tTaskModel);

      // Assert
      expect(result, const Left(DatabaseFailure(error: 'Insert Failed')));
      verify(mockTaskRepository.insertTask(tTaskModel)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
