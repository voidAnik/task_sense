import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_accelerometer_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class AccelerometerCubit extends Cubit<AccelerometerState> {
  AccelerometerCubit(this.getAccelerometerData)
      : super(const AccelerometerState(sensorData: []));
  final List<SensorEntity> sensorData = [];
  final GetAccelerometerData getAccelerometerData;

  void listenSensorData() async {
    getAccelerometerData(params: NoParams()).listen((data) {
      sensorData.add(data);
      emit(AccelerometerState(sensorData: List.from(sensorData)));
    }, onError: (error) {
      log('error getting accelerometer data: $error');
    });
  }
}
