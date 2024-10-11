import 'package:task_sense/features/task_management/data/models/task_list_model.dart';

class TaskListWithCountModel extends TaskListModel {
  final int taskCount;

  TaskListWithCountModel({
    super.id,
    required super.title,
    required super.created,
    required this.taskCount,
  });

  factory TaskListWithCountModel.fromJson(Map<String, dynamic> json) {
    return TaskListWithCountModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      created: DateTime.parse(json['created'] as String),
      taskCount: json['task_count'] as int,
    );
  }
}
