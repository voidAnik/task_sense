import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key, required this.onChange, required this.initialValue});
  final Function(bool value) onChange;
  final bool initialValue;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        value: value,
        side: const BorderSide(
          color: checkboxBorderColor,
        ),
        onChanged: (newValue) {
          setState(() {
            value = newValue!;
          });
          widget.onChange(newValue!);
        },
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return context.theme.primaryColor; // Checked background color
          }
          return secondarySurfaceColor; // Unchecked (inactive) background color
        }),
      ),
    );
  }
}
