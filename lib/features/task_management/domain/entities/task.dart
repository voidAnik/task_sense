class Task {
  final int? id;
  final int taskListId;
  final String taskName;
  final DateTime? dueDate;
  final String? note;
  final bool remindMe;
  final bool isCompleted;

  Task({
    this.id,
    required this.taskListId,
    required this.taskName,
    required this.dueDate,
    this.note,
    this.remindMe = false,
    this.isCompleted = false,
  });
}
