import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/get_due_tasks_cubit.dart';

import 'use_case_mocks_test.mocks.dart';

void main() {
  late GetDueTasksCubit cubit;
  late MockGetTaskDueToday mockGetTaskDueToday;

  setUp(() {
    mockGetTaskDueToday = MockGetTaskDueToday();
    cubit = GetDueTasksCubit(mockGetTaskDueToday);
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

  final tTaskModelList = [tTaskModel, tTaskModel];

  group('GetDueTasksCubit', () {
    blocTest<GetDueTasksCubit, List<TaskModel>>(
      'emits a list of due tasks when fetching tasks is successful',
      build: () {
        when(mockGetTaskDueToday(params: NoParams()))
            .thenAnswer((_) async => Right(tTaskModelList));
        return cubit;
      },
      act: (cubit) => cubit.fetchDueTasks(),
      wait: const Duration(milliseconds: 100), // wait for async call
      expect: () => [
        tTaskModelList, // Expect the emitted state to be the task list
      ],
    );

    blocTest<GetDueTasksCubit, List<TaskModel>>(
      'does not emit anything when fetching tasks fails',
      build: () {
        when(mockGetTaskDueToday(params: NoParams())).thenAnswer((_) async =>
            const Left(DatabaseFailure(error: 'Error fetching tasks')));
        return cubit;
      },
      act: (cubit) => cubit.fetchDueTasks(),
      wait: const Duration(milliseconds: 100), // wait for async call
      expect: () => [], // Expect no state emission
    );
  });
}
