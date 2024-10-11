import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/widgets/custom_checkbox.dart';
import 'package:task_sense/core/widgets/error_widget.dart';
import 'package:task_sense/core/widgets/loading_widget.dart';
import 'package:task_sense/core/widgets/toggle_star.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().listenTasks();
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      if (state is TaskLoaded) {
        final tasks = state.tasks;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return _createListItem2(context, task: tasks[index]);
              }),
        );
      } else if (state is TaskError) {
        return ErrorMessage(error: state.error);
      }
      return const LoadingWidget();
    });
  }

  Card _createListItem(BuildContext context, {required TaskModel task}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.1,
      shadowColor: Colors.black,
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CustomCheckbox(
          onChange: (value) {},
          initialValue: task.isCompleted,
        ),
        title: Text(
          task.taskName,
        ),
        titleAlignment: ListTileTitleAlignment.center,
        titleTextStyle:
            context.textStyle.titleSmall!.copyWith(color: secondaryTextColor),
        subtitle: task.dueDate != null
            ? Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Text(
                    DateFormat('dd MMMM').format(task.dueDate!),
                  ),
                ],
              )
            : null,
        subtitleTextStyle: context.textStyle.bodySmall!.copyWith(
          color: secondaryTextColor,
          fontSize: 10,
        ),
        trailing: ToggleStar(
          onChange: (bool value) {},
        ),
      ),
    );
  }

  Card _createListItem2(BuildContext context, {required TaskModel task}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.1,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        child: Row(
          children: [
            CustomCheckbox(
              onChange: (value) {},
              initialValue: task.isCompleted,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskName,
                  style: context.textStyle.bodyMedium!,
                ),
                if (task.dueDate != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: disabledIconColor,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        DateFormat('dd MMMM').format(task.dueDate!),
                        style: context.textStyle.bodySmall!.copyWith(
                          color: hintTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Spacer(),
            ToggleStar(
              onChange: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }
}
