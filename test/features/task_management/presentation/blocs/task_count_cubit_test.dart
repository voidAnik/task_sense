import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_count_cubit.dart';

import 'use_case_mocks_test.mocks.dart';

void main() {
  late TaskCountCubit cubit;
  late MockGetTaskCount mockGetTaskCount;

  setUp(() {
    mockGetTaskCount = MockGetTaskCount();
    cubit = TaskCountCubit(mockGetTaskCount);
  });

  final tTaskCount = TaskCount(completeCount: 5, incompleteCount: 3);

  group('TaskCountCubit', () {
    blocTest<TaskCountCubit, TaskCount>(
      'emits task count when fetching is successful',
      build: () {
        when(mockGetTaskCount(params: NoParams()))
            .thenAnswer((_) async => Right(tTaskCount));
        return cubit;
      },
      act: (cubit) => cubit.taskCount(),
      wait: const Duration(milliseconds: 100), // wait for async call
      expect: () => [
        tTaskCount, // Expect the emitted state to be the task count
      ],
    );

    blocTest<TaskCountCubit, TaskCount>(
      'does not emit anything when fetching task count fails',
      build: () {
        when(mockGetTaskCount(params: NoParams())).thenAnswer((_) async =>
            const Left(DatabaseFailure(error: 'Error fetching task count')));
        return cubit;
      },
      act: (cubit) => cubit.taskCount(),
      wait: const Duration(milliseconds: 100), // wait for async call
      expect: () => [], // Expect no state emission
    );
  });
}
