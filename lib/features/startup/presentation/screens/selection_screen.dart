import 'package:flutter/material.dart';
import 'package:task_sense/config/theme/colors.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

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
          _createButton(context, text: 'A TO-DO List', onPressed: () {}),
          SizedBox(
            height: context.height * 0.03,
          ),
          _createButton(context,
              text: 'Sensor Tracking',
              backgroundColor: buttonBG,
              textColor: Colors.white,
              onPressed: () {})
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
