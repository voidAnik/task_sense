// Mocks generated by Mockito 5.4.4 from annotations
// in task_sense/test/features/task_management/presentation/blocs/use_case_mocks_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:task_sense/core/error/failures.dart' as _i5;
import 'package:task_sense/core/use_cases/use_case.dart' as _i10;
import 'package:task_sense/features/task_management/data/models/task_list_model.dart'
    as _i6;
import 'package:task_sense/features/task_management/data/models/task_list_with_count_model.dart'
    as _i14;
import 'package:task_sense/features/task_management/data/models/task_model.dart'
    as _i12;
import 'package:task_sense/features/task_management/domain/entities/task_count.dart'
    as _i9;
import 'package:task_sense/features/task_management/domain/use_cases/add_task.dart'
    as _i16;
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart'
    as _i3;
import 'package:task_sense/features/task_management/domain/use_cases/delete_task.dart'
    as _i7;
import 'package:task_sense/features/task_management/domain/use_cases/get_task_count.dart'
    as _i8;
import 'package:task_sense/features/task_management/domain/use_cases/get_task_due_today.dart'
    as _i11;
import 'package:task_sense/features/task_management/domain/use_cases/get_task_list.dart'
    as _i13;
import 'package:task_sense/features/task_management/domain/use_cases/get_tasks.dart'
    as _i15;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddTaskList].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTaskList extends _i1.Mock implements _i3.AddTaskList {
  MockAddTaskList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> call(
          {required _i6.TaskListModel? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, int>>.value(
            _FakeEither_0<_i5.Failure, int>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, int>>);
}

/// A class which mocks [DeleteTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTask extends _i1.Mock implements _i7.DeleteTask {
  MockDeleteTask() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> call(
          {required _i7.DeleteParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}

/// A class which mocks [GetTaskCount].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskCount extends _i1.Mock implements _i8.GetTaskCount {
  MockGetTaskCount() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i9.TaskCount>> call(
          {required _i10.NoParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i9.TaskCount>>.value(
            _FakeEither_0<_i5.Failure, _i9.TaskCount>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i9.TaskCount>>);
}

/// A class which mocks [GetTaskDueToday].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskDueToday extends _i1.Mock implements _i11.GetTaskDueToday {
  MockGetTaskDueToday() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i12.TaskModel>>> call(
          {required _i10.NoParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i12.TaskModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i12.TaskModel>>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i12.TaskModel>>>);
}

/// A class which mocks [GetTaskList].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskList extends _i1.Mock implements _i13.GetTaskList {
  MockGetTaskList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i14.TaskListWithCountModel>>> call(
          {required _i10.NoParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<
                _i2
                .Either<_i5.Failure, List<_i14.TaskListWithCountModel>>>.value(
            _FakeEither_0<_i5.Failure, List<_i14.TaskListWithCountModel>>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i14.TaskListWithCountModel>>>);
}

/// A class which mocks [GetTasks].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTasks extends _i1.Mock implements _i15.GetTasks {
  MockGetTasks() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<List<_i12.TaskModel>> call({required int? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Stream<List<_i12.TaskModel>>.empty(),
      ) as _i4.Stream<List<_i12.TaskModel>>);

  @override
  void closeStream() => super.noSuchMethod(
        Invocation.method(
          #closeStream,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AddTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTask extends _i1.Mock implements _i16.AddTask {
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> call(
          {required _i12.TaskModel? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, void>>.value(
                _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
