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
    super.isMarked,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[taskColumnId] as int?,
      taskListId: json[taskColumnTaskListId] as int,
      taskName: json[taskColumnTaskName] as String,
      dueDate: json[taskColumnDueDate] != null
          ? DateTime.parse(json[taskColumnDueDate] as String)
          : null,
      note: json[taskColumnNote] as String?,
      remindMe: json[taskColumnRemindMe] == 1,
      isCompleted: json[taskColumnIsCompleted] == 1,
      isMarked: json[taskColumnIsMarked] == 1,
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
      taskColumnIsMarked: isMarked ? 1 : 0,
    };
  }

  TaskModel copyWith({
    int? id,
    int? taskListId,
    String? taskName,
    DateTime? dueDate,
    String? note,
    bool? remindMe,
    bool? isCompleted,
    bool? isMarked,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskListId: taskListId ?? this.taskListId,
      taskName: taskName ?? this.taskName,
      dueDate: dueDate ?? this.dueDate,
      note: note ?? this.note,
      remindMe: remindMe ?? this.remindMe,
      isCompleted: isCompleted ?? this.isCompleted,
      isMarked: isMarked ?? this.isMarked,
    );
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, taskListId: $taskListId, taskName: $taskName, dueDate: $dueDate, note: $note, remindMe: $remindMe, isCompleted: $isCompleted, isMarked: $isMarked}';
  }
}
