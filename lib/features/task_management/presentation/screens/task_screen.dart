import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';
import 'package:task_sense/features/task_management/presentation/widgets/add_task_modal.dart';
import 'package:task_sense/features/task_management/presentation/widgets/circular_button.dart';

class TaskScreen extends StatelessWidget {
  static const String path = '/task_screen';

  TaskScreen({super.key});

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: secondarySurfaceColor,
          appBar: AppBar(
            backgroundColor: secondarySurfaceColor,
            title: Text(LocaleKeys.taskListsTitle.tr()),
          ),
          body: _createBody(context),
          floatingActionButton: _createFAB(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  Widget _createFAB(BuildContext parentContext) {
    return Visibility(
      visible: MediaQuery.of(parentContext).viewInsets.bottom == 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () {
            if (parentContext.read<TaskCubit>().taskListId != null) {
              showModalBottomSheet(
                backgroundColor: parentContext.theme.colorScheme.surface,
                context: parentContext,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => AddTaskModal(
                  taskListId: parentContext.read<TaskCubit>().taskListId!,
                ),
              );
            }
          },
          child: Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const CircularIcon(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    LocaleKeys.addTask.tr(),
                    style: parentContext.textStyle.titleSmall!
                        .copyWith(color: secondaryTextColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            style: context.textStyle.titleLarge,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: LocaleKeys.taskTitleHint.tr(),
                hintStyle: context.textStyle.titleLarge!.copyWith(
                  color: hintTextColor,
                ),
                focusedBorder: InputBorder.none,
                fillColor: secondarySurfaceColor),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              context.read<TaskCubit>().addTaskList(
                      taskTitle: TaskListModel(
                    title: value,
                    created: DateTime.now(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
