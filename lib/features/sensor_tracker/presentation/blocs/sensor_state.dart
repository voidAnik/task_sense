import 'package:equatable/equatable.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';

abstract class SensorState extends Equatable {
  final List _props;

  const SensorState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class SensorInitial extends SensorState {}

class SensorError extends SensorState {
  final String error;

  const SensorError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class SensorLoaded extends SensorState {
  final List<SensorEntity> sensorData;
  final bool highMovement;

  const SensorLoaded({this.sensorData = const [], this.highMovement = false});

  SensorLoaded copyWith({
    List<SensorEntity>? sensorData,
    bool? highMovement,
  }) {
    return SensorLoaded(
      sensorData: sensorData ?? this.sensorData,
      highMovement: highMovement ?? this.highMovement,
    );
  }

  @override
  List<Object> get props => [sensorData];
}
