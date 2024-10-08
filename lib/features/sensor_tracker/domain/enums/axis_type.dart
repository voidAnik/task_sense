import 'package:flutter/material.dart';

enum AxisType {
  x(
    value: 'X-axis',
    color: Colors.blue,
  ),
  y(value: 'Y-axis', color: Colors.green),
  z(value: 'Z-axis', color: Colors.red);

  const AxisType({
    required this.value,
    required this.color,
  });

  final String value;
  final Color color;
}
