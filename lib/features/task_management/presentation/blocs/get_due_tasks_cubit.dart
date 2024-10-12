import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_due_today.dart';

class GetDueTasksCubit extends Cubit<List<TaskModel>> {
  final GetTaskDueToday _getTaskDueToday;
  GetDueTasksCubit(this._getTaskDueToday) : super([]);

  Future<void> fetchDueTasks() async {
    final responseOrFailure = await _getTaskDueToday(params: NoParams());
    responseOrFailure.fold((failure) {
      log('getting due tasks failed: $failure');
    }, (dueTasks) {
      log('getting due tasks success: $dueTasks');
      emit(List.from(dueTasks));
    });
  }
}
