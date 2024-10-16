import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_sense/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call({required Params params});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
