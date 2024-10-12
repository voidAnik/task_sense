import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/constants/assets.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/features/task_management/data/models/task_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_edit_cubit.dart';
import 'package:task_sense/features/task_management/presentation/widgets/date_picker_modal.dart';
import 'package:task_sense/features/task_management/presentation/widgets/delete_bottom_sheet.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String path = '/task_details_screen';

  const TaskDetailsScreen(
      {super.key, required this.task, required this.taskListId});

  final TaskModel task;
  final int taskListId;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    if (widget.task.note != null) {
      _noteController.text = widget.task.note!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<TaskEditCubit>()..initState(widget.task, widget.taskListId),
        ),
        BlocProvider(
          create: (context) => getIt<TaskCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              width: context.width * 0.5,
              child: Text(
                widget.task.taskName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            actions: [_createDoneButton(context)],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: _createDeleteButton(context),
          body: _createBody(context),
        );
      }),
    );
  }

  Container _createDoneButton(BuildContext context) {
    return Container(
      width: 64,
      height: 32,
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.all(
            context.theme.primaryColor,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          context.read<TaskEditCubit>().addTask();
          Navigator.of(context).pop(true);
        },
        child: Text(
          LocaleKeys.done.tr(),
          style: context.textStyle.titleSmall!
              .copyWith(color: const Color(0xFFF2F2F2)),
        ),
      ),
    );
  }

  Padding _createDeleteButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          _showDeleteModal(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage(Assets.iconsDelete),
              color: Colors.redAccent,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              LocaleKeys.delete.tr(),
              style: context.textStyle.titleSmall!
                  .copyWith(color: disabledIconColor),
            ),
          ],
        ),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: BlocBuilder<TaskEditCubit, TaskEditState>(
        builder: (context, state) {
          return Column(
            children: [
              _createRemindOption(context, state),
              const SizedBox(
                height: 16,
              ),
              _createDueDateOption(state, context),
              const SizedBox(
                height: 16,
              ),
              _createAddNoteOption(state, context),
            ],
          );
        },
      ),
    );
  }

  Widget _createAddNoteOption(TaskEditState state, BuildContext context) {
    return BlocBuilder<TaskEditCubit, TaskEditState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<TaskEditCubit>().toggleNote();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  FocusScope.of(context).requestFocus(_focusNode);
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.sticky_note_2_outlined,
                    color: (state.note != null || state.openNote)
                        ? context.theme.primaryColor
                        : disabledIconColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    (state.note != null || state.openNote)
                        ? LocaleKeys.inputNote.tr()
                        : LocaleKeys.addNote.tr(),
                    style: context.textStyle.bodyLarge!.copyWith(
                        color: (state.note != null || state.openNote)
                            ? context.theme.primaryColor
                            : disabledIconColor),
                  ),
                ],
              ),
            ),
            if (state.note != null || state.openNote) _noteInput(context)
          ],
        );
      },
    );
  }

  Widget _noteInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        //autofocus: true,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        focusNode: _focusNode,
        controller: _noteController,
        style: context.textStyle.bodyMedium,
        decoration: InputDecoration(
          fillColor: context.theme.colorScheme.surface,
          hintText: LocaleKeys.addNoteHint.tr(),
          hintStyle: context.textStyle.bodyMedium!.copyWith(
            color: hintTextColor,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        maxLines: 4,
        onChanged: (value) {
          context.read<TaskEditCubit>().setNote(value);
        },
        onSubmitted: (value) {
          if (value.isEmpty) {
            context.read<TaskEditCubit>().toggleNote();
          } else {
            context.read<TaskEditCubit>().setNote(value);
          }
        },
      ),
    );
  }

  Widget _createDueDateOption(TaskEditState state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDatePicker(context);
      },
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: _getColor(state.dueDate != null, context),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            state.dueDate != null
                ? 'Due ${DateFormat('EEE, dd MMM').format(state.dueDate!)}'
                : LocaleKeys.addDueDate.tr(),
            style: context.textStyle.bodyLarge!.copyWith(
              color: _getColor(state.dueDate != null, context),
            ),
          )
        ],
      ),
    );
  }

  Widget _createRemindOption(BuildContext context, TaskEditState state) {
    return GestureDetector(
      onTap: () {
        context.read<TaskEditCubit>().toggleRemindMe();
      },
      child: Row(
        children: [
          Icon(
            Icons.notifications_none,
            color: _getColor(state.remindMe, context),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            LocaleKeys.remindMe.tr(),
            style: context.textStyle.bodyLarge!.copyWith(
              color: _getColor(state.remindMe, context),
            ),
          )
        ],
      ),
    );
  }

  Color _getColor(bool condition, BuildContext context) {
    return condition ? context.theme.primaryColor : disabledIconColor;
  }

  Future<void> _showDatePicker(BuildContext parentContext) async {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DatePickerModal(onSelection: (selectedDate) {
          parentContext.read<TaskEditCubit>().setDueDate(selectedDate);
        });
      },
    );
  }

  Future<void> _showDeleteModal(BuildContext parentContext) async {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: parentContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DeleteBottomSheet(
          onDelete: () {
            parentContext.read<TaskCubit>().deleteTask(
                taskId: widget.task.id!, taskListId: widget.taskListId);
            Navigator.of(context).pop(false);
          },
        );
      },
    );
  }
}
