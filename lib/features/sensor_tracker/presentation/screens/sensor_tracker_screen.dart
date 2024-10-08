import 'package:flutter/material.dart';

class SensorTrackerScreen extends StatelessWidget {
  static const String path = '/sensor_tracker_screen';
  const SensorTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {}
}
