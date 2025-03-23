import 'dart:developer';
import '../../export.dart';

class AllTaskScreen extends ConsumerWidget {
  const AllTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBuild = ref.watch(allTaskGetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("All Tasks")),
      body: LoadingDataScreen(
          varBuild: getBuild,
          data: (data) {
            List<TaskModel> prodList =
                data.map<TaskModel>((task) => TaskModel.fromMap(task)).toList();
            return ListView.builder(
              itemCount: prodList.length,
              itemBuilder: (context, index) {
                TaskModel task = prodList[index];
                return TaskChip(
                  task: task,
                  onDelete: () => _deleteTask(task.id, ref),
                  onStatusToggle: () => _toggleTaskStatus(task.id, ref),
                );
              },
            );
          }),
    );
  }

  void _toggleTaskStatus(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).update(taskId);
  }

  // Function to delete the task
  void _deleteTask(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).delete(taskId);
  }
}

class PendingTaskScreen extends ConsumerWidget {
  const PendingTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBuild = ref.watch(allTaskGetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Tasks")),
      body: LoadingDataScreen(
          varBuild: getBuild,
          data: (data) {
            data.removeWhere(
                (task) => task['status'].toString().toLowerCase() != 'pending');
            List<TaskModel> prodList =
                data.map<TaskModel>((task) => TaskModel.fromMap(task)).toList();
            return ListView.builder(
              itemCount: prodList.length,
              itemBuilder: (context, index) {
                TaskModel task = prodList[index];
                return TaskChip(
                  task: task,
                  onDelete: () => _deleteTask(task.id, ref),
                  onStatusToggle: () => _toggleTaskStatus(task.id, ref),
                );
              },
            );
          }),
    );
  }

  void _toggleTaskStatus(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).update(taskId);
  }

  // Function to delete the task
  void _deleteTask(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).delete(taskId);
  }
}

class HomePendingTask extends ConsumerWidget {
  const HomePendingTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBuild = ref.watch(allTaskGetProvider);
    return LoadingDataScreen(
        varBuild: getBuild,
        data: (data) {
          data.removeWhere(
              (task) => task['status'].toString().toLowerCase() != 'pending');
          List<TaskModel> prodList =
              data.map<TaskModel>((task) => TaskModel.fromMap(task)).toList();
          return ListView.builder(
            itemCount: prodList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              TaskModel task = prodList[index];
              return TaskChip(
                task: task,
                onDelete: () => _deleteTask(task.id, ref),
                onStatusToggle: () => _toggleTaskStatus(task.id, ref),
              );
            },
          );
        });
  }

  void _toggleTaskStatus(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).update(taskId);
  }

  // Function to delete the task
  void _deleteTask(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).delete(taskId);
  }
}

class CompletedTaskScreen extends ConsumerWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBuild = ref.watch(allTaskGetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Completed Tasks")),
      body: LoadingDataScreen(
          varBuild: getBuild,
          data: (data) {
            data.removeWhere((task) =>
                task['isCompleted'].toString().toLowerCase() == 'false');
            List<TaskModel> prodList =
                data.map<TaskModel>((task) => TaskModel.fromMap(task)).toList();
            return ListView.builder(
              itemCount: prodList.length,
              itemBuilder: (context, index) {
                TaskModel task = prodList[index];
                return TaskChip(
                  task: task,
                  onDelete: () => _deleteTask(task.id, ref),
                  onStatusToggle: () => _toggleTaskStatus(task.id, ref),
                );
              },
            );
          }),
    );
  }

  void _toggleTaskStatus(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).update(taskId);
  }

  // Function to delete the task
  void _deleteTask(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).delete(taskId);
  }
}

class TodayTaskScreen extends ConsumerWidget {
  const TodayTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getBuild = ref.watch(allTaskGetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Today’s Tasks")),
      body: LoadingDataScreen(
          varBuild: getBuild,
          data: (data) {
            DateTime today = DateTime.now();
            DateTime todayDateOnly =
                DateTime(today.year, today.month, today.day);
            List<TaskModel> prodList = data
                .where((task) {
                  DateTime inputDate = DateTime.parse(task['createdDate']);
                  DateTime inputDateOnly =
                      DateTime(inputDate.year, inputDate.month, inputDate.day);
                  log("is run");
                  return inputDateOnly.isAtSameMomentAs(todayDateOnly);
                })
                .map<TaskModel>((task) => TaskModel.fromMap(task))
                .toList();
            // List<TaskModel> prodList = data.map<TaskModel>((task) {
            //   DateTime inputDate = DateTime.parse(task['createdDate']);
            //   DateTime today = DateTime.now();
            //   DateTime todayDateOnly =
            //       DateTime(today.year, today.month, today.day);
            //   if (inputDate.isAtSameMomentAs(todayDateOnly)) {
            //     TaskModel.fromMap(task);
            //   }
            // }).toList();
            return ListView.builder(
              itemCount: prodList.length,
              itemBuilder: (context, index) {
                TaskModel task = prodList[index];
                return TaskChip(
                  task: task,
                  onDelete: () => _deleteTask(task.id, ref),
                  onStatusToggle: () => _toggleTaskStatus(task.id, ref),
                );
              },
            );
          }),
    );
  }

  void _toggleTaskStatus(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).update(taskId);
  }

  // Function to delete the task
  void _deleteTask(String taskId, WidgetRef ref) {
    ref.watch(apiControllerProvider).delete(taskId);
  }
}
