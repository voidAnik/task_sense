import 'package:mockito/annotations.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task.dart';
import 'package:task_sense/features/task_management/domain/use_cases/add_task_list.dart';
import 'package:task_sense/features/task_management/domain/use_cases/delete_task.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_count.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_due_today.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_task_list.dart';
import 'package:task_sense/features/task_management/domain/use_cases/get_tasks.dart';

@GenerateMocks([
  AddTaskList,
  DeleteTask,
  GetTaskCount,
  GetTaskDueToday,
  GetTaskList,
  GetTasks
])
@GenerateNiceMocks([MockSpec<AddTask>()])
main() {}
