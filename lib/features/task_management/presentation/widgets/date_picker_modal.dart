import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';

class DatePickerModal extends StatefulWidget {
  final Function(DateTime) onSelection;

  const DatePickerModal({super.key, required this.onSelection});

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              datePickerTheme: DatePickerThemeData(
                weekdayStyle: TextStyle(
                  color: context.theme.primaryColor,
                ),
              ),
            ),
            child: CalendarDatePicker(
              initialDate: selectedDate,
              onDateChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: context.textStyle.headlineSmall!.copyWith(
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      context.theme.primaryColor,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onSelection(selectedDate);
                },
                child: Text(
                  LocaleKeys.done.tr(),
                  style: context.textStyle.headlineSmall!
                      .copyWith(color: const Color(0xFFF2F2F2)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
