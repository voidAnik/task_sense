import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/sensor_tracker/domain/entities/sensor.dart';
import 'package:task_sense/features/sensor_tracker/domain/repositories/sensor_repository.dart';

class GetGyroscopeData implements StreamUseCase<SensorEntity, NoParams> {
  final SensorRepository repository;

  GetGyroscopeData(this.repository);

  @override
  Stream<SensorEntity> call({required NoParams params}) {
    return repository.getGyroscopeData();
  }
}
