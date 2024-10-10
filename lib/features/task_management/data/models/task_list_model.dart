import 'package:task_sense/features/task_management/domain/entities/task_list.dart';

class TaskListModel extends TaskList {
  TaskListModel({
    super.id,
    required super.title,
    required super.description,
  });

  factory TaskListModel.fromJson(Map<String, dynamic> json) {
    return TaskListModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
