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
  const TaskListWidget({super.key, required this.onPressed});
  final Function(TaskModel task) onPressed;

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
                return _createListItem(context, task: tasks[index]);
              }),
        );
      } else if (state is TaskError) {
        return ErrorMessage(error: state.error);
      }
      return const LoadingWidget();
    });
  }

  Widget _createListItem(BuildContext context, {required TaskModel task}) {
    return GestureDetector(
      onTap: () => onPressed(task),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0.1,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CustomCheckbox(
                onChange: (value) {
                  context
                      .read<TaskCubit>()
                      .addTask(task: task.copyWith(isCompleted: value));
                },
                initialValue: task.isCompleted,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskName,
                      style: context.textStyle.bodyMedium!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              ),
              ToggleStar(
                isMarked: task.isMarked,
                onChange: (bool value) {
                  context
                      .read<TaskCubit>()
                      .addTask(task: task.copyWith(isMarked: value));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
