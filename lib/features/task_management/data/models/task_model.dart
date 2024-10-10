import 'package:task_sense/features/task_management/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.taskListId,
    required super.taskName,
    required super.dueDate,
    super.note,
    super.remindMe,
    super.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int?,
      taskListId: json['taskListId'] as int,
      taskName: json['taskName'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      note: json['note'] as String?,
      remindMe: json['remindMe'] == 1,
      isCompleted: json['isCompleted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskListId': taskListId,
      'taskName': taskName,
      'dueDate': dueDate.toIso8601String(),
      'note': note,
      'remindMe': remindMe ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
