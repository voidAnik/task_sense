import 'package:equatable/equatable.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';

abstract class SensorState extends Equatable {
  final List _props;

  const SensorState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class AccelerometerState extends SensorState {
  final List<SensorEntity> sensorData;

  const AccelerometerState({
    required this.sensorData,
  });
}

class GyroState extends SensorState {
  final List<SensorEntity> sensorData;
  final String activity;

  const GyroState({this.sensorData = const [], this.activity = ''});

  GyroState copyWith({
    List<SensorEntity>? sensorData,
    String? activity,
  }) {
    return GyroState(
      sensorData: sensorData ?? this.sensorData,
      activity: activity ?? this.activity,
    );
  }
}
