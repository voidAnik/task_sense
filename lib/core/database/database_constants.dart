const String databaseName = 'task_management.db';
const int dbVersion = 1;

// Table names
const String taskListsTable = 'task_lists';
const String tasksTable = 'tasks';

// Columns for task lists
const String taskListColumnId = 'id';
const String taskListColumnTitle = 'title';
const String taskListColumnCreated = 'created';

// Columns for tasks
const String taskColumnId = 'id';
const String taskColumnTaskListId = 'task_list_id';
const String taskColumnTaskName = 'task_name';
const String taskColumnDueDate = 'due_date';
const String taskColumnNote = 'note';
const String taskColumnRemindMe = 'remind_me';
const String taskColumnIsCompleted = 'is_completed';
