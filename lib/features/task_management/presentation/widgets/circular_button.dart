import 'package:flutter/material.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class CircularIcon extends StatelessWidget {
  final Icon icon;
  const CircularIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        color: context.theme.primaryColor,
        borderRadius: BorderRadius.circular(16),
        child: icon);
  }
}
