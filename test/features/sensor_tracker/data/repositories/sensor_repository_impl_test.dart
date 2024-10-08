import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:task_sense/features/sensor_tracker/data/repositories/sensor_repository_impl.dart';

import 'sensor_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Sensors>()])
void main() {
  group('SensorRepositoryImpl Tests', () {
    late SensorRepositoryImpl sensorRepository;
    late MockSensors mockSensors;

    setUp(() {
      mockSensors = MockSensors();
      sensorRepository = SensorRepositoryImpl(mockSensors);
    });

    test('getAccelerometerData emits SensorEntity on success', () async {
      // Arrange: Create a mock AccelerometerEvent
      final accelerometerEvent =
          AccelerometerEvent(1.0, 2.0, 3.0, DateTime.now());

      // Mocking the accelerometerEventStream
      when(mockSensors.accelerometerEventStream())
          .thenAnswer((_) => Stream.fromIterable([accelerometerEvent]));

      // Act: Listen for the stream
      final results = await sensorRepository.getAccelerometerData().toList();

      // Assert: Check that the emitted values are as expected
      // we cant compare directly cause the timestamp is changing
      expect(results[0].x, accelerometerEvent.x);
      expect(results[0].y, accelerometerEvent.y);
      expect(results[0].z, accelerometerEvent.z);
      expect(
          results[0].timestamp, isNotNull); // Ensure the timestamp is not null
    });

    test('getGyroscopeData emits SensorEntity on success', () async {
      // Arrange: Create a mock GyroscopeEvent with dummy data including timestamp
      final gyroscopeEvent = GyroscopeEvent(4.0, 5.0, 6.0, DateTime.now());

      // Mocking the gyroscopeEventStream
      when(mockSensors.gyroscopeEventStream())
          .thenAnswer((_) => Stream.fromIterable([gyroscopeEvent]));

      // Act: Listen for the stream
      final results = await sensorRepository.getGyroscopeData().toList();

      // Assert: Check that the emitted values are as expected
      expect(results[0].x, gyroscopeEvent.x);
      expect(results[0].y, gyroscopeEvent.y);
      expect(results[0].z, gyroscopeEvent.z);
      expect(
          results[0].timestamp, isNotNull); // Ensure the timestamp is not null
    });
  });
}
