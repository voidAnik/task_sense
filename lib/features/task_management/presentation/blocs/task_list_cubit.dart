import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTaskList _addTaskList;
  TaskCubit(this._addTaskList) : super(TaskInitial());

  int? taskListId;

  Future<void> addTaskList({required TaskListModel taskTitle}) async {
    // setting id to replace previous task list
    if (taskListId != null) {
      taskTitle = taskTitle.copyWith(id: taskListId);
    }
    final responseOrFailure = await _addTaskList(params: taskTitle);
    responseOrFailure.fold((failure) {
      log('task list adding failed: $failure');
    }, (id) {
      log('task list added successfully with id: $id');
      taskListId = id;
    });
  }
}
