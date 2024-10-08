import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_gyroscope_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/sensor_state.dart';

class GyroCubit extends Cubit<SensorState> {
  GyroCubit(this.getGyroscopeData) : super(SensorInitial());
  final List<SensorEntity> sensorData = [];
  final GetGyroscopeData getGyroscopeData;
  StreamSubscription<SensorEntity>? _subscription;
  final Duration samplingDuration = const Duration(milliseconds: 500);

  bool isOnAlert = false;

  void listenSensorData() async {
    _subscription = getGyroscopeData(params: NoParams()).listen((data) {
      // controlling sampling rate as sampling rate doesn't work from sensor_plus on some device
      if (sensorData.isEmpty ||
          DateTime.now().difference(sensorData.last.timestamp) >=
              samplingDuration) {
        sensorData.add(data);
        //log('data: $data');
        if (_isHighMovement(data)) {
          // emit for high movement
          emit(SensorLoaded(
              sensorData: List.from(sensorData), highMovement: true));
        } else {
          emit(SensorLoaded(
              sensorData: List.from(sensorData), highMovement: false));
        }
      }
    }, onError: (error) {
      log('error getting gyroscope data: $error');
      emit(SensorError(error: error.toString()));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  bool _isHighMovement(SensorEntity data) {
    int countHighAxes = 0;

    // checking with different threshold after testing
    if (data.x.abs() > 3) countHighAxes++;
    if (data.y.abs() > 3) countHighAxes++;
    if (data.z.abs() > 5) countHighAxes++;
    //log('checking threshold: ${data.x} , ${data.y}, ${data.z} && $countHighAxes');
    // Return true if at least two axes have high movement
    return countHighAxes >= 2;
  }
}
