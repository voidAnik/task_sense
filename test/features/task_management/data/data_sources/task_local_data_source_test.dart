import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/database/task_dao.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';

import 'task_local_data_source_test.mocks.dart';

@GenerateMocks([TaskDao])
void main() {
  late MockTaskDao mockTaskDao;
  late TaskLocalDataSourceImpl dataSource;

  setUp(() {
    mockTaskDao = MockTaskDao();
    dataSource = TaskLocalDataSourceImpl(mockTaskDao);
  });

  final TaskModel tTaskModel = TaskModel(
    id: 1,
    taskListId: 1,
    taskName: 'Test Task',
    dueDate: DateTime.now(),
    note: 'Test Note',
    remindMe: true,
    isCompleted: false,
    isMarked: false,
  );

  final TaskCount tTaskCount = TaskCount(
    completeCount: 5,
    incompleteCount: 10,
  );

  const int tTaskId = 1;

  group('insertTask', () {
    test('should insert task successfully', () async {
      // Arrange
      when(mockTaskDao.insertTask(tTaskModel))
          .thenAnswer((_) async => Future.value());

      // Act
      await dataSource.insertTask(tTaskModel);

      // Assert
      verify(mockTaskDao.insertTask(tTaskModel)).called(1);
    });

    test('should throw DatabaseException when inserting task fails', () async {
      // Arrange
      when(mockTaskDao.insertTask(tTaskModel))
          .thenThrow(Exception('Insert failed'));

      // Act
      final call = dataSource.insertTask(tTaskModel);

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('getAllTasks', () {
    test('should get all tasks for a specific task list successfully',
        () async {
      // Arrange
      final testTaskModels = [tTaskModel];
      when(mockTaskDao.getAllTasks(tTaskId))
          .thenAnswer((_) async => testTaskModels);

      // Act
      final result = await dataSource.getAllTasks(tTaskId);

      // Assert
      expect(result, testTaskModels);
      verify(mockTaskDao.getAllTasks(tTaskId)).called(1);
    });

    test('should throw DatabaseException when getting all tasks fails',
        () async {
      // Arrange
      when(mockTaskDao.getAllTasks(1)).thenThrow(Exception('Get tasks failed'));

      // Act
      final call = dataSource.getAllTasks(1);

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('getTodayTasks', () {
    test('should get today\'s tasks successfully', () async {
      // Arrange
      final testTodayTasks = [tTaskModel];
      when(mockTaskDao.getTasksDueToday())
          .thenAnswer((_) async => testTodayTasks);

      // Act
      final result = await dataSource.getTodayTasks();

      // Assert
      expect(result, testTodayTasks);
      verify(mockTaskDao.getTasksDueToday()).called(1);
    });

    test('should throw DatabaseException when getting today\'s tasks fails',
        () async {
      // Arrange
      when(mockTaskDao.getTasksDueToday())
          .thenThrow(Exception('Get today tasks failed'));

      // Act
      final call = dataSource.getTodayTasks();

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('deleteTask', () {
    test('should delete task by ID successfully', () async {
      // Arrange
      when(mockTaskDao.deleteTask(tTaskId))
          .thenAnswer((_) async => Future.value());

      // Act
      await dataSource.deleteTask(tTaskId);

      // Assert
      verify(mockTaskDao.deleteTask(tTaskId)).called(1);
    });

    test('should throw DatabaseException when deleting task fails', () async {
      // Arrange
      when(mockTaskDao.deleteTask(1))
          .thenThrow(Exception('Delete task failed'));

      // Act
      final call = dataSource.deleteTask(1);

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('countTasks', () {
    test('should count tasks successfully', () async {
      // Arrange
      when(mockTaskDao.countTasks()).thenAnswer((_) async => tTaskCount);

      // Act
      final result = await dataSource.countTasks();

      // Assert
      expect(result, tTaskCount);
      verify(mockTaskDao.countTasks()).called(1);
    });

    test('should throw DatabaseException when counting tasks fails', () async {
      // Arrange
      when(mockTaskDao.countTasks()).thenThrow(Exception('Count tasks failed'));

      // Act
      final call = dataSource.countTasks();

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });
}
