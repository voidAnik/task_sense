import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/widgets/error_widget.dart';
import 'package:task_sense/core/widgets/loading_widget.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';

class TaskTitleListWidget extends StatelessWidget {
  const TaskTitleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskListCubit>()..fetch(),
      child: BlocBuilder<TaskListCubit, TaskState>(builder: (context, state) {
        if (state is TaskListLoaded) {
          final taskList = state.taskList;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0.1,
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: ListTile(
                      leading: ImageIcon(
                        const AssetImage(Assets.iconsList),
                        color: context.theme.primaryColor,
                      ),
                      title: Text(
                        taskList[index].title,
                      ),
                      titleTextStyle: context.textStyle.titleSmall!
                          .copyWith(color: secondaryTextColor),
                      subtitle: Text(
                        DateFormat('dd MMMM').format(taskList[index].created),
                      ),
                      subtitleTextStyle: context.textStyle.bodySmall!.copyWith(
                        color: secondaryTextColor,
                        fontSize: 10,
                      ),
                      trailing: Text(
                        taskList[index].taskCount.toString(),
                        style: context.textStyle.titleMedium!.copyWith(
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else if (state is TaskError) {
          return ErrorMessage(error: state.error);
        }
        return const LoadingWidget();
      }),
    );
  }
}
