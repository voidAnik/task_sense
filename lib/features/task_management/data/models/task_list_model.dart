import 'package:task_sense/features/task_management/domain/entities/task_list.dart';

class TaskListModel extends TaskList {
  TaskListModel({
    super.id,
    required super.title,
    required super.created,
  });

  factory TaskListModel.fromJson(Map<String, dynamic> json) {
    return TaskListModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      created: DateTime.parse(json['dueDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': created.toIso8601String(),
    };
  }

  TaskListModel copyWith({
    int? id,
    String? title,
    DateTime? created,
  }) {
    return TaskListModel(
      id: id ?? this.id,
      title: title ?? this.title,
      created: created ?? this.created,
    );
  }
}
