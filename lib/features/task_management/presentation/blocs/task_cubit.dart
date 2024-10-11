import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_tasks.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final AddTaskList _addTaskList;
  final GetTasks _getTasks;

  TaskCubit(this._addTaskList, this._getTasks) : super(TaskInitial());

  int? taskListId;

  Future<void> addTaskList({required TaskListModel taskTitle}) async {
    // setting id to replace previous task list
    if (taskListId != null) {
      taskTitle = taskTitle.copyWith(id: taskListId);
    }
    final responseOrFailure = await _addTaskList(params: taskTitle);
    responseOrFailure.fold((failure) {
      log('task list adding failed: $failure');
      emit(TaskInitial());
    }, (id) {
      log('task list added successfully with id: $id');
      taskListId = id;
    });
  }

  void listenTasks() {
    emit(TaskLoading());
    if (taskListId != null) {
      _getTasks(params: taskListId!).listen((tasks) {
        log('tasks loaded by stream for taskListID: $taskListId tasks: $tasks');
        emit(TaskLoaded(tasks: tasks));
      }, onError: (error) {
        log('tasks loading failed by stream: $error');
        emit(TaskError(error: error));
      });
    } else {
      emit(TaskError(error: 'taskListId is null or not found'));
    }
  }

  @override
  Future<void> close() {
    _getTasks.closeStream();
    return super.close();
  }
}
