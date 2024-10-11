import 'package:task_sense/core/database/database_constants.dart';
import 'package:task_sense/features/task_management/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.taskListId,
    required super.taskName,
    super.dueDate,
    super.note,
    super.remindMe,
    super.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[taskColumnId] as int?,
      taskListId: json[taskColumnTaskListId] as int,
      taskName: json[taskColumnTaskName] as String,
      dueDate: DateTime.parse(json[taskColumnDueDate] as String),
      note: json[taskColumnNote] as String?,
      remindMe: json[taskColumnRemindMe] == 1,
      isCompleted: json[taskColumnIsCompleted] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      taskColumnId: id,
      taskColumnTaskListId: taskListId,
      taskColumnTaskName: taskName,
      taskColumnDueDate: dueDate?.toIso8601String(),
      taskColumnNote: note,
      taskColumnRemindMe: remindMe ? 1 : 0,
      taskColumnIsCompleted: isCompleted ? 1 : 0,
    };
  }
}
