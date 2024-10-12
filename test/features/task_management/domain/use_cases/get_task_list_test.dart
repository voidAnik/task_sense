import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_list_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_list.dart';

import 'repository_mocks_test.mocks.dart';

@GenerateMocks([TaskListRepository])
void main() {
  late GetTaskList useCase;
  late MockTaskListRepository mockTaskListRepository;

  setUp(() {
    mockTaskListRepository = MockTaskListRepository();
    useCase = GetTaskList(mockTaskListRepository);
  });

  final tTaskListWithCountModel = TaskListWithCountModel(
    id: 1,
    title: 'Task List 1',
    created: DateTime.now(),
    taskCount: 5,
  );

  final tTaskListWithCount = [tTaskListWithCountModel, tTaskListWithCountModel];

  group('GetTaskListUseCase', () {
    test(
        'should return a list of TaskListWithCountModel when repository call is successful',
        () async {
      // Arrange
      when(mockTaskListRepository.getAllTaskLists())
          .thenAnswer((_) async => Right(tTaskListWithCount));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result, Right(tTaskListWithCount));
      verify(mockTaskListRepository.getAllTaskLists()).called(1);
      verifyNoMoreInteractions(mockTaskListRepository);
    });

    test('should return DatabaseFailure when repository call fails', () async {
      // Arrange
      when(mockTaskListRepository.getAllTaskLists()).thenAnswer((_) async =>
          const Left(DatabaseFailure(error: 'Failed to get task lists')));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result,
          const Left(DatabaseFailure(error: 'Failed to get task lists')));
      verify(mockTaskListRepository.getAllTaskLists()).called(1);
      verifyNoMoreInteractions(mockTaskListRepository);
    });
  });
}
