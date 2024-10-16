import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/features/sensor_tracker/presentation/screens/sensor_tracker_screen.dart';
import 'package:task_sense/features/startup/presentation/screens/splash_screen.dart';

class SelectionScreen extends StatelessWidget {
  static const String path = '/selection_screen';
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFF4F3F3), Color(0xFFFBFBFB)], stops: [0, 1])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createButton(context, text: LocaleKeys.todoList.tr(), onPressed: () {
            context.push(SplashScreen.path);
          }),
          SizedBox(
            height: context.height * 0.03,
          ),
          _createButton(context,
              text: LocaleKeys.sensorTracking.tr(),
              backgroundColor: buttonBGColor,
              textColor: Colors.white, onPressed: () {
            context.push(SensorTrackerScreen.path);
          })
        ],
      ),
    );
  }

  Widget _createButton(BuildContext context,
      {required String text,
      Color? backgroundColor,
      Color? textColor,
      required VoidCallback onPressed}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      width: context.width,
      height: context.width * 0.15,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(backgroundColor ?? primaryColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
            elevation: WidgetStateProperty.all(4)),
        child: Text(
          text,
          style: context.textStyle.bodyLarge!.copyWith(
            color: textColor ?? Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
