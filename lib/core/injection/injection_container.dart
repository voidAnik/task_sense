import 'package:get_it/get_it.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:task_sense/core/database/database_manager.dart';
import 'package:task_sense/core/database/task_dao.dart';
import 'package:task_sense/core/database/task_list_dao.dart';
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
  getIt.registerLazySingleton(() => DatabaseManager());
  final db = await getIt<DatabaseManager>().database;
  getIt
    ..registerLazySingleton(() => TaskListDao(db))
    ..registerLazySingleton(() => TaskDao(db));

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
