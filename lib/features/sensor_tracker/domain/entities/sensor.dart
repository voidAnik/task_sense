import 'package:equatable/equatable.dart';

class SensorEntity extends Equatable {
  final double x;
  final double y;
  final double z;
  final DateTime timestamp;

  const SensorEntity({
    required this.x,
    required this.y,
    required this.z,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'SensorEntity{x: $x, y: $y, z: $z, timestamp: $timestamp}';
  }

  @override
  List<Object?> get props => [x, y, z, timestamp];
}
