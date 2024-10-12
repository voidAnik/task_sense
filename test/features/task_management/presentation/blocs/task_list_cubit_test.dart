import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

import 'use_case_mocks_test.mocks.dart';

void main() {
  late TaskListCubit cubit;
  late MockGetTaskList mockGetTaskList;

  setUp(() {
    mockGetTaskList = MockGetTaskList();
    cubit = TaskListCubit(mockGetTaskList);
  });
  final tTaskListWithCountModel = TaskListWithCountModel(
    id: 1,
    title: 'Test Task List',
    created: DateTime.now(),
    taskCount: 5,
  );

  test('initial state is TaskInitial', () {
    expect(cubit.state, TaskInitial());
  });

  blocTest<TaskListCubit, TaskState>(
    'fetches task lists successfully',
    build: () {
      when(mockGetTaskList(params: NoParams())).thenAnswer(
        (_) async => Right([
          tTaskListWithCountModel,
        ]),
      );
      return cubit;
    },
    act: (cubit) => cubit.fetchTaskLists(),
    expect: () => [
      TaskListLoaded(taskList: [
        tTaskListWithCountModel,
      ]),
    ],
  );

  blocTest<TaskListCubit, TaskState>(
    'fetching task lists fails',
    build: () {
      when(mockGetTaskList(params: NoParams())).thenAnswer(
        (_) async => const Left(DatabaseFailure(
            error: 'Database Error')), // Replace with your actual failure type
      );
      return cubit;
    },
    act: (cubit) => cubit.fetchTaskLists(),
    expect: () => [
      //nothing emits on failed
    ],
  );
}
