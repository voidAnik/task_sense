import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/repositories/sensor_repository.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_accelerometer_data.dart';

import 'get_accelerometer_data_test.mocks.dart';

@GenerateMocks([SensorRepository])
void main() {
  late GetAccelerometerData getAccelerometerData;
  late MockSensorRepository mockSensorRepository;

  setUp(() {
    mockSensorRepository = MockSensorRepository();
    getAccelerometerData = GetAccelerometerData(mockSensorRepository);
  });

  test('GetAccelerometerData returns stream of SensorEntity', () async {
    // Arrange: Create a mock SensorEntity
    final accelerometerData = SensorEntity(
      x: 1.0,
      y: 2.0,
      z: 3.0,
      timestamp: DateTime.now(),
    );

    // Mocking the getAccelerometerData method
    when(mockSensorRepository.getAccelerometerData())
        .thenAnswer((_) => Stream.fromIterable([accelerometerData]));

    // Act
    final stream = getAccelerometerData.call(params: NoParams());

    // Assert
    expectLater(stream, emitsInOrder([accelerometerData]));
  });
}
