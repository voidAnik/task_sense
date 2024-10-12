import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_list.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

class TaskListCubit extends Cubit<TaskState> {
  final GetTaskList _getTaskList;
  TaskListCubit(this._getTaskList) : super(TaskInitial());

  Future<void> fetch() async {
    final responseOrFailure = await _getTaskList(params: NoParams());
    responseOrFailure.fold((failure) {
      log('getting task list failed: $failure');
    }, (taskList) {
      log('getting task list success: $taskList');
      emit(TaskListLoaded(taskList: taskList));
    });
  }
}

class TaskListLoaded extends TaskState {
  final List<TaskListWithCountModel> taskList;

  TaskListLoaded({
    required this.taskList,
  });

  @override
  List<Object> get props => [taskList];
}
