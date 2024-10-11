import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_sense/core/extensions/context_extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: SpinKitThreeInOut(
        size: 32,
        color: context.theme.primaryColor,
      ),
    ));
  }
}
