import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

import 'use_case_mocks_test.mocks.dart';

void main() {
  late TaskCubit cubit;
  late MockAddTaskList mockAddTaskList;
  late MockGetTasks mockGetTasks;
  late MockAddTask mockAddTask;
  late MockDeleteTask mockDeleteTask;

  setUp(() {
    mockAddTaskList = MockAddTaskList();
    mockGetTasks = MockGetTasks();
    mockAddTask = MockAddTask();
    mockDeleteTask = MockDeleteTask();
    cubit =
        TaskCubit(mockAddTaskList, mockGetTasks, mockAddTask, mockDeleteTask);
  });

  final tTaskListModel =
      TaskListModel(id: 1, title: 'Test Task List', created: DateTime.now());
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
  final tTaskModelList = [tTaskModel];

  group('TaskCubit', () {
    blocTest<TaskCubit, TaskState>(
      'emits TaskLoaded when tasks are successfully loaded',
      build: () {
        when(mockGetTasks(params: anyNamed('params')))
            .thenAnswer((_) => Stream.value(tTaskModelList));
        return cubit;
      },
      act: (cubit) {
        cubit.taskListId = 1;
        cubit.listenTasks();
      },
      expect: () => [
        TaskLoading(),
        TaskLoaded(tasks: tTaskModelList),
      ],
    );

    blocTest<TaskCubit, TaskState>(
      'emits TaskError when tasks loading fails',
      build: () {
        when(mockGetTasks(params: anyNamed('params')))
            .thenAnswer((_) => Stream.error('Error loading tasks'));
        return cubit;
      },
      act: (cubit) {
        cubit.taskListId = 1;
        cubit.listenTasks();
      },
      expect: () => [
        TaskLoading(),
        isA<TaskError>(), // Check for TaskError
      ],
    );

    blocTest<TaskCubit, TaskState>(
      'successfully adds a task list',
      build: () {
        when(mockAddTaskList(params: anyNamed('params')))
            .thenAnswer((_) async => const Right(1)); // Simulate success
        return cubit;
      },
      act: (cubit) => cubit.addTaskList(taskTitle: tTaskListModel),
      expect: () => [
        // nothing emits just i assigned the taskListId
      ],
    );

    blocTest<TaskCubit, TaskState>(
      'successfully adds a task',
      build: () {
        when(mockAddTask(params: anyNamed('params')))
            .thenAnswer((_) async => const Right(null)); // Simulate success
        return cubit;
      },
      act: (cubit) => cubit.addTask(task: tTaskModel),
      expect: () => [], // No state change, as this method does not emit state
    );

    blocTest<TaskCubit, TaskState>(
      'successfully deletes a task',
      build: () {
        when(mockDeleteTask(params: anyNamed('params')))
            .thenAnswer((_) async => const Right(null)); // Simulate success
        return cubit;
      },
      act: (cubit) => cubit.deleteTask(
          taskId: tTaskModel.id!, taskListId: tTaskModel.taskListId),
      expect: () => [], // No state change, as this method does not emit state
    );
  });

  tearDown(() {
    cubit.close(); // Close the cubit after each test
  });
}
