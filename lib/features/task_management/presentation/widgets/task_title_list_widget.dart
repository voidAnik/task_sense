import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/widgets/error_widget.dart';
import 'package:task_sense/core/widgets/loading_widget.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_title_list_item_widget.dart';

class TaskTitleListWidget extends StatelessWidget {
  const TaskTitleListWidget({super.key, required this.onTap});

  final Function(TaskListModel) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskState>(builder: (context, state) {
      if (state is TaskListLoaded) {
        final taskList = state.taskList;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return TaskListItemWidget(
                    onTap: onTap,
                    taskList: taskList[index],
                  );
                }),
          ),
        );
      } else if (state is TaskError) {
        return ErrorMessage(error: state.error);
      }
      return const LoadingWidget();
    });
  }
}
