import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_gyroscope_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/gyro_cubit.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

import 'gyro_cubit_test.mocks.dart';

@GenerateMocks([GetGyroscopeData])
void main() {
  group('GyroCubit Test', () {
    late GyroCubit gyroCubit;
    late MockGetGyroscopeData mockGetGyroscopeData;
    late SensorEntity sensorData;

    setUp(() {
      mockGetGyroscopeData = MockGetGyroscopeData();
      gyroCubit = GyroCubit(mockGetGyroscopeData);
      sensorData =
          SensorEntity(x: 1.0, y: 2.0, z: 3.0, timestamp: DateTime.now());
    });

    test('initial state is SensorInitial', () {
      expect(gyroCubit.state, SensorInitial());
    });

    blocTest<GyroCubit, SensorState>(
      'emits [SensorLoaded] with sensor data when gyroscope data is received',
      build: () {
        // Mocking the stream to emit sensor data
        when(mockGetGyroscopeData.call(params: NoParams()))
            .thenAnswer((_) => Stream.fromIterable([sensorData]));

        return gyroCubit;
      },
      act: (cubit) => gyroCubit.listenSensorData(),
      expect: () => [
        SensorLoaded(
          sensorData: [sensorData],
          highMovement: false,
        )
      ],
    );

    blocTest<GyroCubit, SensorState>(
      'emits [SensorLoaded] with highMovement true when high movement is detected',
      build: () {
        when(mockGetGyroscopeData.call(params: NoParams()))
            .thenAnswer((_) => Stream.fromIterable([sensorData]));

        return gyroCubit;
      },
      act: (cubit) => cubit.listenSensorData(),
      expect: () => [
        SensorLoaded(
          sensorData: [sensorData],
          highMovement: true, // High movement should be true
        ),
      ],
    );

    blocTest<GyroCubit, SensorState>(
      'emits [SensorError] when an error occurs',
      build: () {
        when(mockGetGyroscopeData.call(params: NoParams()))
            .thenAnswer((_) => Stream.error(Exception('Error fetching data')));

        return gyroCubit;
      },
      act: (cubit) => cubit.listenSensorData(),
      expect: () => [
        const SensorError(error: 'Exception: Error fetching data'),
      ],
    );
  });
}
