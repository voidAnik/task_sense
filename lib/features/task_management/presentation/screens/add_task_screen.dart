import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/injection/injection_container.dart';
import 'package:task_sense/features/task_management/data/models/task_list_model.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';
import 'package:task_sense/features/task_management/presentation/widgets/add_task_modal.dart';

class AddTaskScreen extends StatelessWidget {
  static const String path = '/add_task_screen';

  AddTaskScreen({super.key});

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
            title: const Text('Lists'),
          ),
          body: _createBody(context),
          floatingActionButton: _createFAB(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }),
    );
  }

  Widget _createFAB(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Ensures the keyboard adjusts the modal
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => AddTaskModal(),
          );
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Material(
                  elevation: 4,
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'Add a task',
                  style: context.textStyle.titleSmall!
                      .copyWith(color: secondaryTextColor),
                ),
              ],
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
                hintText: 'Untitled List',
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

  Widget _buildBottomSheetContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text input field with a tick icon
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your task",
                    border: InputBorder.none, // Borderless text field
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check), // Tick/To-do button
                onPressed: () {
                  // Handle task submission
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Row of icons (bell, note, calendar)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle bell icon click
                },
              ),
              IconButton(
                icon: const Icon(Icons.note),
                onPressed: () {
                  // Handle note icon click
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  // Handle calendar icon click
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
