import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/repositories/sensor_repository.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_gyroscope_data.dart';

import 'get_accelerometer_data_test.mocks.dart';

@GenerateMocks([SensorRepository])
void main() {
  late GetGyroscopeData getGyroscopeData;
  late MockSensorRepository mockSensorRepository;

  setUp(() {
    mockSensorRepository = MockSensorRepository();
    getGyroscopeData = GetGyroscopeData(mockSensorRepository);
  });

  test('GetGyroscopeData returns stream of SensorEntity', () async {
    // arrange: create a mock SensorEntity
    final gyroData =
        SensorEntity(x: 1.0, y: 2.0, z: 3.0, timestamp: DateTime.now());

    // mocking the getGyroscopeData method
    when(mockSensorRepository.getGyroscopeData())
        .thenAnswer((_) => Stream.fromIterable([gyroData]));

    // Act
    final stream = getGyroscopeData(params: NoParams());

    // Assert
    expect(stream, emitsInOrder([gyroData]));
  });
}
