import 'package:sensors_plus/sensors_plus.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/repositories/sensor_repository.dart';

class SensorRepositoryImpl implements SensorRepository {
  final Sensors sensors;

  SensorRepositoryImpl(this.sensors);

  @override
  Stream<SensorEntity> getAccelerometerData() async* {
    // Listen to the accelerometer event stream
    yield* sensors
        .accelerometerEventStream()
        .map<SensorEntity>((AccelerometerEvent event) {
      return SensorEntity(
        x: event.x,
        y: event.y,
        z: event.z,
        timestamp: DateTime.now(), // Use current timestamp for each event
      );
    });
  }

  @override
  Stream<SensorEntity> getGyroscopeData() async* {
    // Listen to the gyroscope event stream
    yield* sensors
        .gyroscopeEventStream()
        .map<SensorEntity>((GyroscopeEvent event) {
      return SensorEntity(
        x: event.x,
        y: event.y,
        z: event.z,
        timestamp: DateTime.now(), // Use current timestamp for each event
      );
    });
  }
}
