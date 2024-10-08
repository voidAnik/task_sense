import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:task_sense/core/extensions/context_extension.dart';
import 'package:task_sense/core/language/generated/locale_keys.g.dart';
import 'package:task_sense/features/sensor_tracker/presentation/widgets/accelerometer_chart_widget.dart';

import '../widgets/gyroscope_chart_widget.dart';

class SensorTrackerScreen extends StatelessWidget {
  static const String path = '/sensor_tracker_screen';
  const SensorTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.sensorTrackerTitle.tr()),
        centerTitle: true,
      ),
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: context.height * 0.35,
          child: const GyroscopeChartWidget(),
        ),
        const AccelerometerChartWidget(),
      ],
    );
  }
}
