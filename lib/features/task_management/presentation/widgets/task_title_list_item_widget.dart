import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart';

class TaskListItemWidget extends StatelessWidget {
  const TaskListItemWidget({
    super.key,
    required this.onTap,
    required this.taskList,
  });

  final Function(TaskListModel taskList) onTap;
  final TaskListWithCountModel taskList;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.1,
      shadowColor: Colors.black,
      color: Colors.white,
      child: ListTile(
        onTap: () => onTap(taskList),
        leading: ImageIcon(
          const AssetImage(Assets.iconsList),
          color: context.theme.primaryColor,
        ),
        title: Text(
          taskList.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        titleTextStyle:
            context.textStyle.titleSmall!.copyWith(color: secondaryTextColor),
        subtitle: Text(
          DateFormat('dd MMMM').format(taskList.created),
        ),
        subtitleTextStyle: context.textStyle.bodySmall!.copyWith(
          color: secondaryTextColor,
          fontSize: 10,
        ),
        trailing: Text(
          taskList.taskCount.toString(),
          style: context.textStyle.titleMedium!.copyWith(
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
