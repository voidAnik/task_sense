import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_gyroscope_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class GyroCubit extends Cubit<GyroState> {
  GyroCubit(this.getGyroscopeData) : super(const GyroState());
  final List<SensorEntity> sensorData = [];
  final GetGyroscopeData getGyroscopeData;

  void listenSensorData() async {
    getGyroscopeData(params: NoParams()).listen((data) {
      sensorData.add(data);
      emit(GyroState(sensorData: List.from(sensorData)));
    }, onError: (error) {
      log('error getting accelerometer data: $error');
    });
  }
}
