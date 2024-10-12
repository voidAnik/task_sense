import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/core/use_cases/use_case.dart';
import 'package:task_sense/features/task_management/domain/entities/task_count.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_count.dart';

import 'repository_mocks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late GetTaskCount useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTaskCount(mockTaskRepository);
  });

  final tTaskCount = TaskCount(incompleteCount: 10, completeCount: 5);

  group('GetTaskCountUseCase', () {
    test('should return TaskCount when repository call is successful',
        () async {
      // Arrange
      when(mockTaskRepository.countTasks())
          .thenAnswer((_) async => Right(tTaskCount));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result, Right(tTaskCount));
      verify(mockTaskRepository.countTasks()).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return DatabaseFailure when repository call fails', () async {
      // Arrange
      when(mockTaskRepository.countTasks()).thenAnswer(
          (_) async => const Left(DatabaseFailure(error: 'Count Failed')));

      // Act
      final result = await useCase(params: NoParams());

      // Assert
      expect(result, const Left(DatabaseFailure(error: 'Count Failed')));
      verify(mockTaskRepository.countTasks()).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
