import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_sense/core/error/failures.dart';
import 'package:task_sense/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_sense/features/task_management/domain/use_cases/delete_task.dart';

import 'repository_mocks_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late DeleteTask useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = DeleteTask(mockTaskRepository);
  });

  const tTaskId = 1;
  const tTaskListId = 1;
  final tDeleteParams = DeleteParams(tTaskId, tTaskListId);

  group('DeleteTaskUseCase', () {
    test('should call deleteTask on the repository', () async {
      // Arrange
      when(mockTaskRepository.deleteTask(any, any))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(params: tDeleteParams);

      // Assert
      expect(result, const Right(null));
      verify(mockTaskRepository.deleteTask(tTaskId, tTaskListId)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return DatabaseFailure when deletion fails', () async {
      // Arrange
      when(mockTaskRepository.deleteTask(any, any)).thenAnswer(
          (_) async => const Left(DatabaseFailure(error: 'Delete Failed')));

      // Act
      final result = await useCase(params: tDeleteParams);

      // Assert
      expect(result, const Left(DatabaseFailure(error: 'Delete Failed')));
      verify(mockTaskRepository.deleteTask(tTaskId, tTaskListId)).called(1);
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
