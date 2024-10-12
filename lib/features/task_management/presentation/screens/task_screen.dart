import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_state.dart';
import 'package:task_sense/features/task_management/presentation/widgets/add_task_modal.dart';
import 'package:task_sense/features/task_management/presentation/widgets/circular_button.dart';
import 'package:task_sense/features/task_management/presentation/widgets/task_list_widget.dart';

class TaskScreen extends StatefulWidget {
  static const String path = '/task_screen';

  const TaskScreen({super.key, required this.taskList});

  final TaskListModel? taskList;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  @override
  void initState() {
    if (widget.taskList == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    } else {
      _titleController.text = widget.taskList!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (widget.taskList == null) {
          return getIt<TaskCubit>();
        } else {
          return getIt<TaskCubit>()..taskListId = widget.taskList!.id;
        }
      },
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
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
                backgroundColor: Colors.white,
                context: parentContext,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => AddTaskModal(
                  taskListId: parentContext.read<TaskCubit>().taskListId!,
                ),
              );
            } else {
              _showWarningSnackBar(context, 'No task tile found!');
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
    return Column(
      children: [
        _createTopWidget(context),
        BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (context.read<TaskCubit>().taskListId != null) {
              return TaskListWidget(
                onPressed: (task) {
                  context.push(
                      '${TaskScreen.path}?id=${context.read<TaskCubit>().taskListId!}',
                      extra: task);
                },
              );
            }
            return Container();
          },
        )
      ],
    );
  }

  Widget _createTopWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            focusNode: _focusNode,
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
          ),
        ],
      ),
    );
  }

  void _showWarningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.warning,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            message,
            style: context.textStyle.titleMedium!
                .copyWith(color: Colors.white), // Text color
          ),
        ],
      ),
      backgroundColor: Colors.deepOrangeAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
