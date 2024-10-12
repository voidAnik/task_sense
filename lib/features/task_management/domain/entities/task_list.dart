import 'package:equatable/equatable.dart';

class TaskList extends Equatable {
  final int? id;
  final String title;
  final DateTime created;

  const TaskList({
    this.id,
    required this.title,
    required this.created,
  });

  @override
  List<Object?> get props => [id, title, created];
}
