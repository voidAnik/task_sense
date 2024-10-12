import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/database/task_list_dao.dart';
import 'package:task_sense/core/error/exceptions.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_list_local_data_source.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

import 'task_list_local_data_source_test.mocks.dart';

@GenerateMocks([TaskListDao])
void main() {
  late MockTaskListDao mockTaskListDao;
  late TaskListLocalDataSourceImpl taskListLocalDataSource;

  setUp(() {
    mockTaskListDao = MockTaskListDao();
    taskListLocalDataSource = TaskListLocalDataSourceImpl(mockTaskListDao);
  });

  final tTaskList = TaskListModel(
    id: 1,
    title: 'Test Task List',
    created: DateTime.now(),
  );

  final tTaskListsWithCount = [
    TaskListWithCountModel(
      id: 1,
      title: 'Test Task List 1',
      created: DateTime.now(),
      taskCount: 3,
    ),
    TaskListWithCountModel(
      id: 2,
      title: 'Test Task List 2',
      created: DateTime.now(),
      taskCount: 5,
    ),
  ];

  group('insertTaskList', () {
    test('should insert a task list successfully', () async {
      // Arrange
      when(mockTaskListDao.insertTaskList(tTaskList))
          .thenAnswer((_) async => 1);

      // Act
      final result = await taskListLocalDataSource.insertTaskList(tTaskList);

      // Assert
      expect(result, 1);
      verify(mockTaskListDao.insertTaskList(tTaskList)).called(1);
    });

    test('should throw DatabaseException when inserting fails', () async {
      // Arrange
      when(mockTaskListDao.insertTaskList(tTaskList))
          .thenThrow(Exception('Insert failed'));

      // Act
      final call = taskListLocalDataSource.insertTaskList(tTaskList);

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('getAllTaskLists', () {
    test('should get all task lists with task count successfully', () async {
      // Arrange
      when(mockTaskListDao.getTaskListsWithCount())
          .thenAnswer((_) async => tTaskListsWithCount);

      // Act
      final result = await taskListLocalDataSource.getAllTaskLists();

      // Assert
      expect(result, tTaskListsWithCount);
      verify(mockTaskListDao.getTaskListsWithCount()).called(1);
    });

    test('should throw DatabaseException when getting task lists fails',
        () async {
      // Arrange
      when(mockTaskListDao.getTaskListsWithCount())
          .thenThrow(Exception('Get failed'));

      // Act
      final call = taskListLocalDataSource.getAllTaskLists();

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });

  group('deleteTaskList', () {
    test('should delete a task list successfully', () async {
      // Arrange
      when(mockTaskListDao.deleteTaskList(1))
          .thenAnswer((_) async => Future.value());

      // Act
      await taskListLocalDataSource.deleteTaskList(1);

      // Assert
      verify(mockTaskListDao.deleteTaskList(1)).called(1);
    });

    test('should throw DatabaseException when deleting task list fails',
        () async {
      // Arrange
      when(mockTaskListDao.deleteTaskList(1))
          .thenThrow(Exception('Delete failed'));

      // Act
      final call = taskListLocalDataSource.deleteTaskList(1);

      // Assert
      expect(call, throwsA(isA<DatabaseException>()));
    });
  });
}
