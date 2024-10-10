import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_count.dart';

class TaskCountCubit extends Cubit<TaskCount> {
  final GetTaskCount _getTaskCount;
  TaskCountCubit(this._getTaskCount)
      : super(TaskCount(completeCount: 0, incompleteCount: 0));

  Future<void> taskCount() async {
    final responseOrFailure = await _getTaskCount(params: NoParams());
    responseOrFailure.fold((failure) {
      log('error getting task count $failure');
    }, (taskCount) {
      log('success getting task count $taskCount');
      emit(taskCount);
    });
  }
}
