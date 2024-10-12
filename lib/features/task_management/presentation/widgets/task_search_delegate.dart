import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_title_list_item_widget.dart';

class TaskSearchDelegate extends SearchDelegate<String> {
  final List<TaskListWithCountModel> taskList;
  TaskSearchDelegate({
    required this.taskList,
    required this.onTap,
  });
  final Function(TaskListModel taskList) onTap;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor:
            context.theme.colorScheme.surface, // Your desired color
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none, // Optional: remove underline
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<TaskListWithCountModel> filteredList = query.isEmpty
        ? []
        : taskList
            .where((task) =>
                task.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    log('filtered list: ${filteredList.length} and query $query');
    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          'No task category found!',
          style: GoogleFonts.abel(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return TaskListItemWidget(onTap: onTap, taskList: filteredList[index]);
      },
    );
  }
}
