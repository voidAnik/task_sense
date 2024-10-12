import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/core/widgets/custom_checkbox.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_modal_cubit.dart';
import 'package:task_sense/features/task_management/presentation/widgets/date_picker_modal.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key, required this.taskListId});
  final int taskListId;

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _showDatePicker(BuildContext parentContext) async {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DatePickerModal(onSelection: (selectedDate) {
          parentContext.read<TaskModalCubit>().setDueDate(selectedDate);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskModalCubit>(),
      child: Builder(builder: (context) {
        context.read<TaskModalCubit>().taskListId = widget.taskListId;
        return AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerInput(context),
              _noteInput(context),
              const SizedBox(height: 20),
              _createOptionButtons(context),
            ],
          ),
        );
      }),
    );
  }

  BlocBuilder<TaskModalCubit, TaskModalState> _noteInput(BuildContext context) {
    return BlocBuilder<TaskModalCubit, TaskModalState>(
      builder: (context, state) {
        if (state.openNote) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              //controller: _noteController,
              style: context.textStyle.bodyMedium,
              decoration: InputDecoration(
                hintText: LocaleKeys.addNoteHint.tr(),
                hintStyle: context.textStyle.bodyMedium!.copyWith(
                  color: hintTextColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              maxLines: 3,
              onChanged: (value) {
                context.read<TaskModalCubit>().setNote(value);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Row _headerInput(BuildContext context) {
    return Row(
      children: [
        CustomCheckbox(
            onChange: (value) {
              context.read<TaskModalCubit>().toggleComplete();
            },
            initialValue: false),
        Expanded(
          child: TextField(
            focusNode: _focusNode,
            // Auto-focus the text field
            style: context.textStyle.bodyLarge!.copyWith(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: LocaleKeys.taskTitleHint.tr(),
              hintStyle: context.textStyle.bodyLarge!.copyWith(
                color: hintTextColor,
                fontSize: 18,
              ),
              focusedBorder: InputBorder.none,
            ),
            textInputAction: TextInputAction.done,
            autofocus: true,
            onChanged: (value) {
              context.read<TaskModalCubit>().setTaskName(value);
            },
          ),
        ),
        BlocBuilder<TaskModalCubit, TaskModalState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                Icons.check_circle,
                color: state.taskName.isNotEmpty
                    ? context.theme.primaryColor
                    : disabledIconColor,
              ),
              onPressed: () {
                if (state.taskName.isNotEmpty) {
                  context.read<TaskModalCubit>().addTask();
                  Navigator.of(context).pop(true);
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _createOptionButtons(BuildContext context) {
    return BlocBuilder<TaskModalCubit, TaskModalState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: state.remindMe
                    ? context.theme.primaryColor
                    : disabledIconColor,
              ),
              onPressed: () {
                context.read<TaskModalCubit>().toggleRemindMe();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.sticky_note_2_outlined,
                color: state.openNote
                    ? context.theme.primaryColor
                    : disabledIconColor,
              ),
              onPressed: () {
                context.read<TaskModalCubit>().toggleNote();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: state.dueDate != null
                    ? context.theme.primaryColor
                    : disabledIconColor,
              ),
              onPressed: () {
                _showDatePicker(context);
              },
            ),
            if (state.dueDate != null)
              Text(
                DateFormat('EEE, dd MMM').format(state.dueDate!),
                style: context.textStyle.bodyLarge!.copyWith(
                  color: context.theme.primaryColor,
                ),
              )
          ],
        );
      },
    );
  }
}
