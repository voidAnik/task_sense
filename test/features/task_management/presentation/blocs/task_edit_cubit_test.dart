import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_edit_cubit.dart';

import 'use_case_mocks_test.mocks.dart';

void main() {
  late TaskEditCubit cubit;
  late MockAddTask mockAddTask;

  setUp(() {
    mockAddTask = MockAddTask();
    cubit = TaskEditCubit(mockAddTask);
  });

  test('initial state is correct', () {
    expect(cubit.state, const TaskEditState());
  });

  blocTest<TaskEditCubit, TaskEditState>(
    'sets task name',
    build: () => cubit,
    act: (cubit) => cubit.setTaskName('New Task'),
    expect: () => [
      const TaskEditState(taskName: 'New Task'),
    ],
  );

  blocTest<TaskEditCubit, TaskEditState>(
    'sets due date',
    build: () => cubit,
    act: (cubit) => cubit.setDueDate(DateTime(2024, 12, 25)),
    expect: () => [
      TaskEditState(dueDate: DateTime(2024, 12, 25)),
    ],
  );

  blocTest<TaskEditCubit, TaskEditState>(
    'toggles complete status',
    build: () => cubit,
    act: (cubit) {
      cubit.toggleComplete();
      cubit.toggleComplete();
    },
    expect: () => [
      const TaskEditState(isCompleted: true),
      const TaskEditState(isCompleted: false),
    ],
  );
}
