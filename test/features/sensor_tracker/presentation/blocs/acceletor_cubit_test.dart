import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_accelerometer_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/accelerometer_cubit.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

import 'acceletor_cubit_test.mocks.dart';

@GenerateMocks([GetAccelerometerData])
void main() {
  group('AccelerometerCubit Test', () {
    late AccelerometerCubit accelerometerCubit;
    late MockGetAccelerometerData mockGetAccelerometerData;
    late SensorEntity sensorData;

    setUp(() {
      mockGetAccelerometerData = MockGetAccelerometerData();
      accelerometerCubit = AccelerometerCubit(mockGetAccelerometerData);
      sensorData = SensorEntity(
        x: 1.0,
        y: 2.0,
        z: 3.0,
        timestamp: DateTime.now(),
      );
    });

    test('initial state is SensorInitial', () {
      expect(accelerometerCubit.state, SensorInitial());
    });

    blocTest<AccelerometerCubit, SensorState>(
      'emits [SensorLoaded] with sensor data when accelerometer data is received',
      build: () {
        // Mocking the stream to emit sensor data
        when(mockGetAccelerometerData.call(params: NoParams()))
            .thenAnswer((_) => Stream.fromIterable([sensorData]));

        return accelerometerCubit;
      },
      act: (cubit) => cubit.listenSensorData(),
      expect: () => [
        SensorLoaded(sensorData: [sensorData]),
      ],
    );

    blocTest<AccelerometerCubit, SensorState>(
      'emits [SensorError] when an error occurs',
      build: () {
        when(mockGetAccelerometerData.call(params: NoParams()))
            .thenAnswer((_) => Stream.error(Exception('Error fetching data')));

        return accelerometerCubit;
      },
      act: (cubit) => cubit.listenSensorData(),
      expect: () => [
        const SensorError(error: 'Exception: Error fetching data'),
      ],
    );
  });
}
