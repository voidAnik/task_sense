import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.properties = const <dynamic>[]});

  final List properties;

  @override
  List<Object> get props => [properties];
}

class DatabaseFailure extends Failure {
  final String error;
  const DatabaseFailure({required this.error});
}

class InternalFailure extends Failure {
  final String error;
  const InternalFailure({required this.error});
}
