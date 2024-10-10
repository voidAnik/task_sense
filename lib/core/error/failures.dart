import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String error;
  const Failure({required this.error});

  @override
  List<Object> get props => [error];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.error});

  @override
  String toString() {
    return 'DatabaseFailure{error: $error}';
  }
}

class SensorFailure extends Failure {
  const SensorFailure({required super.error});

  @override
  String toString() {
    return 'SensorFailure{error: $error}';
  }
}

class InternalFailure extends Failure {
  const InternalFailure({required super.error});

  @override
  String toString() {
    return 'InternalFailure{}';
  }
}
