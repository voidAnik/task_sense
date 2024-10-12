import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({
    super.key,
    required this.onDelete,
  });
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Align at bottom
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  LocaleKeys.deleteHint.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: disabledIconColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Divider(
                  color: borderColor,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      LocaleKeys.deleteTask.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 16), // Transparent gap between the two sections

          // Lower section (Cancel button)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pop(), // Dismiss modal on cancel
              child: Text(
                LocaleKeys.cancel.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: context.theme.primaryColor, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
