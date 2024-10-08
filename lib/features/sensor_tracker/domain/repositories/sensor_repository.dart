import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';

abstract class SensorRepository {
  Stream<SensorEntity> getAccelerometerData();
  Stream<SensorEntity> getGyroscopeData();
}
