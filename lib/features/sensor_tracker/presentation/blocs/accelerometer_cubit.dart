import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_accelerometer_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class AccelerometerCubit extends Cubit<SensorState> {
  AccelerometerCubit(this.getAccelerometerData) : super(SensorInitial());
  final List<SensorEntity> sensorData = [];
  final GetAccelerometerData getAccelerometerData;
  StreamSubscription<SensorEntity>? _subscription;
  static const Duration samplingDuration = Duration(milliseconds: 1000);

  void listenSensorData() async {
    _subscription = getAccelerometerData(params: NoParams()).listen((data) {
      // controlling sampling rate as sampling rate doesn't work from sensor_plus on some device
      if (sensorData.isEmpty ||
          DateTime.now().difference(sensorData.last.timestamp) >=
              samplingDuration) {
        //log('received accelerometer data: $data');
        sensorData.add(data);
        emit(SensorLoaded(sensorData: List.from(sensorData)));
      }
    }, onError: (error) {
      log('error getting accelerometer data: $error');
      emit(SensorError(error: error.toString()));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
