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
import 'package:task_sense/features/task_management/data/data_sources/task_list_local_data_source.dart';
import 'package:task_sense/features/task_management/data/data_sources/task_local_data_source.dart';
import 'package:task_sense/features/task_management/data/repositories/task_list_repository_impl.dart';
import 'package:task_sense/features/task_management/data/repositories/task_repository_impl.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_list_repository.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart';
import 'package:task_sense/features/task_management/domain/use_cases/delete_task.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_count.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_due_today.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_list.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_tasks.dart';
import 'package:task_sense/features/task_management/presentation/blocs/get_due_tasks_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_count_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_edit_cubit.dart';
import 'package:task_sense/features/task_management/presentation/blocs/task_list_cubit.dart';

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
  getIt
    ..registerLazySingleton<TaskListLocalDataSource>(
        () => TaskListLocalDataSourceImpl(getIt()))
    ..registerLazySingleton<TaskLocalDataSource>(
        () => TaskLocalDataSourceImpl(getIt()));

  //* Repositories
  getIt
    ..registerLazySingleton<SensorRepository>(
        () => SensorRepositoryImpl(getIt()))
    ..registerLazySingleton<TaskListRepository>(
        () => TaskListRepositoryImpl(getIt()))
    ..registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt()));

  //* Use Cases
  getIt
    ..registerLazySingleton(() => GetAccelerometerData(getIt()))
    ..registerLazySingleton(() => GetGyroscopeData(getIt()))
    ..registerLazySingleton(() => GetTaskCount(getIt()))
    ..registerLazySingleton(() => AddTaskList(getIt()))
    ..registerLazySingleton(() => AddTask(getIt()))
    ..registerLazySingleton(() => GetTaskList(getIt()))
    ..registerLazySingleton(() => GetTasks(getIt()))
    ..registerLazySingleton(() => DeleteTask(getIt()))
    ..registerLazySingleton(() => GetTaskDueToday(getIt()));

  //* Blocs
  getIt
    ..registerFactory(() => AccelerometerCubit(getIt()))
    ..registerFactory(() => GyroCubit(getIt()))
    ..registerFactory(() => TaskCountCubit(getIt()))
    ..registerFactory(() => TaskCubit(getIt(), getIt(), getIt(), getIt()))
    ..registerFactory(() => TaskEditCubit(getIt()))
    ..registerFactory(() => TaskListCubit(getIt()))
    ..registerFactory(() => GetDueTasksCubit(getIt()));
}
