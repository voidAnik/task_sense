import 'package:get_it/get_it.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:task_sense/features/sensor_tracker/data/repositories/sensor_repository_impl.dart';
import 'package:task_sense/features/sensor_tracker/domain/repositories/sensor_repository.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_accelerometer_data.dart';
import 'package:task_sense/features/sensor_tracker/domain/use_cases/get_gyroscope_data.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/accelerometer_cubit.dart';
import 'package:task_sense/features/sensor_tracker/presentation/blocs/gyro_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //* Core

  getIt.registerLazySingleton(() => Sensors());

  //? database

  //* data providers

  //* Repositories
  getIt.registerLazySingleton<SensorRepository>(
      () => SensorRepositoryImpl(getIt()));

  //* Use Cases
  getIt
    ..registerLazySingleton(() => GetAccelerometerData(getIt()))
    ..registerLazySingleton(() => GetGyroscopeData(getIt()));

  //* Blocs
  getIt
    ..registerFactory(() => AccelerometerCubit(getIt()))
    ..registerFactory(() => GyroCubit(getIt()));
}
