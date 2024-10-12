import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/data/repositories/task_repository_impl.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TaskLocalDataSource>()])
void main() {
  late MockTaskLocalDataSource mockTaskLocalDataSource;
  late TaskRepositoryImpl repository;

  setUp(() {
    mockTaskLocalDataSource = MockTaskLocalDataSource();
    repository = TaskRepositoryImpl(mockTaskLocalDataSource);
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

  const tTaskListId = 1;
  const tTaskId = 1;

  final tTaskModels = <TaskModel>[tTaskModel, tTaskModel];

  final tTodayTasks = <TaskModel>[tTaskModel];

  final tTaskCount = TaskCount(completeCount: 5, incompleteCount: 10);

  group('TaskRepositoryImpl', () {
    group('insertTask', () {
      test('should insert task and emit updated task list', () async {
        // Arrange
        when(mockTaskLocalDataSource.insertTask(tTaskModel))
            .thenAnswer((_) async => Future.value());

        // Act
        final stream = repository.getTaskStream(tTaskModel.taskListId);
        final future = repository.insertTask(tTaskModel);

        // Verify emitted values
        expectLater(
            stream,
            emitsInOrder([
              emitsAnyOf([isA<List<TaskModel>>()])
            ]));

        await future;

        // Assert
        verify(mockTaskLocalDataSource.insertTask(tTaskModel)).called(1);
      });

      test('should return DatabaseFailure when inserting task fails', () async {
        // Arrange
        when(mockTaskLocalDataSource.insertTask(tTaskModel))
            .thenThrow(DatabaseException(error: 'Insert failed'));

        // Act
        final result = await repository.insertTask(tTaskModel);

        // Assert
        verify(mockTaskLocalDataSource.insertTask(tTaskModel)).called(1);
        expect(result, const Left(DatabaseFailure(error: 'Insert failed')));
      });
    });

    group('deleteTask', () {
      test('should delete task and emit updated task list', () async {
        // Arrange
        when(mockTaskLocalDataSource.deleteTask(tTaskId))
            .thenAnswer((_) async => Future.value());

        // Act
        final stream = repository.getTaskStream(tTaskListId);
        final future = repository.deleteTask(tTaskId, tTaskListId);

        // Verify emitted values
        expectLater(
            stream,
            emitsInOrder([
              emitsAnyOf([isA<List<TaskModel>>()])
            ]));

        await future;

        // Assert
        verify(mockTaskLocalDataSource.deleteTask(tTaskId)).called(1);
      });

      test('should return DatabaseFailure when deleting task fails', () async {
        // Arrange
        when(mockTaskLocalDataSource.deleteTask(tTaskId))
            .thenThrow(DatabaseException(error: 'Delete task failed'));

        // Act
        final result = await repository.deleteTask(tTaskId, tTaskListId);

        // Assert
        verify(mockTaskLocalDataSource.deleteTask(tTaskId)).called(1);
        expect(
            result, const Left(DatabaseFailure(error: 'Delete task failed')));
      });
    });

    group('getAllTasks', () {
      test('should return list of tasks for a specific task list', () async {
        // Arrange
        when(mockTaskLocalDataSource.getAllTasks(tTaskListId))
            .thenAnswer((_) async => tTaskModels);

        // Act
        final result = await repository.getAllTasks(tTaskListId);

        // Assert
        verify(mockTaskLocalDataSource.getAllTasks(tTaskListId)).called(1);
        expect(result, Right(tTaskModels));
      });

      test('should return DatabaseFailure when getting tasks fails', () async {
        // Arrange
        when(mockTaskLocalDataSource.getAllTasks(tTaskListId))
            .thenThrow(DatabaseException(error: 'Get tasks failed'));

        // Act
        final result = await repository.getAllTasks(tTaskListId);

        // Assert
        verify(mockTaskLocalDataSource.getAllTasks(tTaskListId)).called(1);
        expect(result, const Left(DatabaseFailure(error: 'Get tasks failed')));
      });
    });

    group('getTodayTasks', () {
      test('should return today\'s tasks', () async {
        // Arrange
        when(mockTaskLocalDataSource.getTodayTasks())
            .thenAnswer((_) async => tTodayTasks);

        // Act
        final result = await repository.getTodayTasks();

        // Assert
        verify(mockTaskLocalDataSource.getTodayTasks()).called(1);
        expect(result, Right(tTodayTasks));
      });

      test('should return DatabaseFailure when getting today\'s tasks fails',
          () async {
        // Arrange
        when(mockTaskLocalDataSource.getTodayTasks())
            .thenThrow(DatabaseException(error: 'Get today tasks failed'));

        // Act
        final result = await repository.getTodayTasks();

        // Assert
        verify(mockTaskLocalDataSource.getTodayTasks()).called(1);
        expect(result,
            const Left(DatabaseFailure(error: 'Get today tasks failed')));
      });
    });

    group('countTasks', () {
      test('should return task count', () async {
        // Arrange
        when(mockTaskLocalDataSource.countTasks())
            .thenAnswer((_) async => tTaskCount);

        // Act
        final result = await repository.countTasks();

        // Assert
        verify(mockTaskLocalDataSource.countTasks()).called(1);
        expect(result, Right(tTaskCount));
      });

      test('should return DatabaseFailure when counting tasks fails', () async {
        // Arrange
        when(mockTaskLocalDataSource.countTasks())
            .thenThrow(DatabaseException(error: 'Count tasks failed'));

        // Act
        final result = await repository.countTasks();

        // Assert
        verify(mockTaskLocalDataSource.countTasks()).called(1);
        expect(
            result, const Left(DatabaseFailure(error: 'Count tasks failed')));
      });
    });
  });
}
