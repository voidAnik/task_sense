import 'package:flutter/material.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: context.textStyle.titleMedium!.copyWith(color: Colors.red),
      ),
    );
  }
}
