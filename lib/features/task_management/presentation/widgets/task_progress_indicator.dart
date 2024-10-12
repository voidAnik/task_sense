import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class TaskProgressIndicator extends StatelessWidget {
  final Color color;
  final double progress;

  final _height = 3.0;

  const TaskProgressIndicator(
      {super.key, required this.color, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Container(
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    height: _height,
                    width: (progress / 100) * constraints.maxWidth,
                    color: color,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${progress.toInt()}%",
            style: context.textStyle.titleMedium!
                .copyWith(color: secondaryTextColor),
          ),
        )
      ],
    );
  }
}
