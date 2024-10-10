import 'package:flutter/material.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

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

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode, // Auto-focus the text field
                  decoration: const InputDecoration(
                    hintText: "Enter your task",
                    border: InputBorder.none, // Borderless text field
                  ),
                  autofocus: true,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check), // Tick/To-do button
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.note),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
