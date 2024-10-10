import 'package:equatable/equatable.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskError extends TaskState {
  final String error;

  TaskError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  TaskLoaded({
    required this.tasks,
  });

  @override
  List<Object> get props => [tasks];
}
