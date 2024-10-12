import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart';

import 'repository_mocks_test.mocks.dart';

void main() {
  late AddTaskList useCase;
  late MockTaskListRepository mockTaskListRepository;

  setUp(() {
    mockTaskListRepository = MockTaskListRepository();
    useCase = AddTaskList(mockTaskListRepository);
  });

  final tTaskListModel = TaskListModel(
    id: 1,
    title: 'Test Task List',
    created: DateTime.now(),
  );

  group('AddTaskListUseCase', () {
    test('should call insertTaskList on the repository and return task list id',
        () async {
      // Arrange
      when(mockTaskListRepository.insertTaskList(any))
          .thenAnswer((_) async => const Right(1));

      // Act
      final result = await useCase(params: tTaskListModel);

      // Assert
      expect(result, const Right(1));
      verify(mockTaskListRepository.insertTaskList(tTaskListModel)).called(1);
      verifyNoMoreInteractions(mockTaskListRepository);
    });

    test('should return DatabaseFailure when insertion fails', () async {
      // Arrange
      when(mockTaskListRepository.insertTaskList(any)).thenAnswer((_) async =>
          const Left(DatabaseFailure(error: 'Insert Task List Failed')));

      // Act
      final result = await useCase(params: tTaskListModel);

      // Assert
      expect(result,
          const Left(DatabaseFailure(error: 'Insert Task List Failed')));
      verify(mockTaskListRepository.insertTaskList(tTaskListModel)).called(1);
      verifyNoMoreInteractions(mockTaskListRepository);
    });
  });
}
