import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task.dart';

class TaskModalCubit extends Cubit<TaskModalState> {
  final AddTask _addTask;
  TaskModalCubit(this._addTask) : super(const TaskModalState());
  int? taskListId;
  int? taskId;

  void setTaskName(String title) {
    emit(state.copyWith(taskName: title));
  }

  void toggleComplete() {
    emit(state.copyWith(isCompleted: !state.isCompleted));
  }

  void toggleRemindMe() {
    emit(state.copyWith(remindMe: !state.remindMe));
  }

  void setNote(String note) {
    emit(state.copyWith(note: note));
  }

  void toggleNote() {
    emit(state.copyWith(openNote: !state.openNote));
  }

  void setDueDate(DateTime date) {
    emit(state.copyWith(dueDate: date));
  }

  Future<void> addTask() async {
    final TaskModel task = TaskModel(
        taskListId: taskListId!,
        taskName: state.taskName,
        dueDate: state.dueDate,
        note: state.note,
        remindMe: state.remindMe,
        isCompleted: state.isCompleted);
    final responseOrFailure = await _addTask(params: task);
    responseOrFailure.fold((failure) {
      log('task adding failed: $failure');
    }, (_) {
      log('task added successfully $task');
    });
  }
}

class TaskModalState {
  final String taskName;
  final DateTime? dueDate;
  final String? note;
  final bool remindMe;
  final bool isCompleted;
  final bool openNote;

  const TaskModalState({
    this.taskName = '',
    this.dueDate,
    this.note,
    this.remindMe = false,
    this.isCompleted = false,
    this.openNote = false,
  });

  TaskModalState copyWith({
    String? taskName,
    DateTime? dueDate,
    String? note,
    bool? remindMe,
    bool? isCompleted,
    bool? openNote,
  }) {
    return TaskModalState(
      taskName: taskName ?? this.taskName,
      dueDate: dueDate ?? this.dueDate,
      note: note ?? this.note,
      remindMe: remindMe ?? this.remindMe,
      isCompleted: isCompleted ?? this.isCompleted,
      openNote: openNote ?? this.openNote,
    );
  }
}
