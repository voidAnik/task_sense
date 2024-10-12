import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_list_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/data/repositories/task_list_repository_impl.dart';

import 'task_list_repository_impl_test.mocks.dart';

@GenerateMocks([TaskListLocalDataSource])
void main() {
  late TaskListRepositoryImpl repository;
  late MockTaskListLocalDataSource mockTaskListLocalDataSource;

  setUp(() {
    mockTaskListLocalDataSource = MockTaskListLocalDataSource();
    repository = TaskListRepositoryImpl(mockTaskListLocalDataSource);
  });

  group('TaskListRepositoryImpl', () {
    const int tTaskListId = 1;
    final tTaskListModel = TaskListModel(
      id: tTaskListId,
      title: 'Test Task List',
      created: DateTime.now(),
    );

    final tTaskListWithCount = TaskListWithCountModel(
      id: tTaskListId,
      title: 'Test Task List',
      created: DateTime.now(),
      taskCount: 5,
    );

    final tTaskListWithCounts = [tTaskListWithCount];

    group('insertTaskList', () {
      test('should insert task list and return the ID', () async {
        // Arrange
        when(mockTaskListLocalDataSource.insertTaskList(any))
            .thenAnswer((_) async => tTaskListId);

        // Act
        final result = await repository.insertTaskList(tTaskListModel);

        // Assert
        expect(result, const Right(tTaskListId));
        verify(mockTaskListLocalDataSource.insertTaskList(tTaskListModel))
            .called(1);
      });

      test('should return DatabaseFailure when inserting task list fails',
          () async {
        // Arrange
        when(mockTaskListLocalDataSource.insertTaskList(any))
            .thenThrow(DatabaseException(error: 'Insert failed'));

        // Act
        final result = await repository.insertTaskList(tTaskListModel);

        // Assert
        expect(result, const Left(DatabaseFailure(error: 'Insert failed')));
        verify(mockTaskListLocalDataSource.insertTaskList(tTaskListModel))
            .called(1);
      });
    });

    group('getAllTaskLists', () {
      test('should get all task lists with counts', () async {
        // Arrange
        when(mockTaskListLocalDataSource.getAllTaskLists())
            .thenAnswer((_) async => tTaskListWithCounts);

        // Act
        final result = await repository.getAllTaskLists();

        // Assert
        expect(result, Right(tTaskListWithCounts));
        verify(mockTaskListLocalDataSource.getAllTaskLists()).called(1);
      });

      test('should return DatabaseFailure when getting task lists fails',
          () async {
        // Arrange
        when(mockTaskListLocalDataSource.getAllTaskLists())
            .thenThrow(DatabaseException(error: 'Get failed'));

        // Act
        final result = await repository.getAllTaskLists();

        // Assert
        expect(result, const Left(DatabaseFailure(error: 'Get failed')));
        verify(mockTaskListLocalDataSource.getAllTaskLists()).called(1);
      });
    });

    group('deleteTaskList', () {
      test('should delete task list by ID', () async {
        // Arrange
        when(mockTaskListLocalDataSource.deleteTaskList(tTaskListId))
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.deleteTaskList(tTaskListId);

        // Assert
        expect(result, const Right(null));
        verify(mockTaskListLocalDataSource.deleteTaskList(tTaskListId))
            .called(1);
      });

      test('should return DatabaseFailure when deleting task list fails',
          () async {
        // Arrange
        when(mockTaskListLocalDataSource.deleteTaskList(tTaskListId))
            .thenThrow(DatabaseException(error: 'Delete failed'));

        // Act
        final result = await repository.deleteTaskList(tTaskListId);

        // Assert
        expect(result, const Left(DatabaseFailure(error: 'Delete failed')));
        verify(mockTaskListLocalDataSource.deleteTaskList(tTaskListId))
            .called(1);
      });
    });
  });
}
