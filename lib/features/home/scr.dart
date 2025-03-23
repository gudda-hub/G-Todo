import 'dart:ui';

import '../../export.dart';

class TaskTypeCard extends StatelessWidget {
  final TaskType taskType;
  const TaskTypeCard({super.key, required this.taskType});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Adds subtle shadow
      color: taskType.color.withAlpha(60),
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .64,
        child: InkWell(
          onTap: () {
            navigatePush(taskType.widget);
          },
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(taskType.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                heightSizedBox(6.0),
                Text(taskType.caption,
                    style: Theme.of(context).textTheme.bodyLarge),
                // heightSizedBox(30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 60, end: 80),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Icon(taskType.icon,
                          size: value, color: taskType.color);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Card(
    //   color: taskType.color.withOpacity(0.2),
    //   elevation: 0,
    //   margin: const EdgeInsets.all(8),
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    //   child: SizedBox(
    //     height: 200,
    //     width: MediaQuery.of(context).size.width * .64,
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: InkWell(
    //           onTap: () {
    //             navigatePush(taskType.widget);
    //           },
    //           child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(taskType.title,
    //                     style: Theme.of(context)
    //                         .textTheme
    //                         .titleLarge
    //                         ?.copyWith(fontWeight: FontWeight.w700)),
    //                 heightSizedBox(6.0),
    //                 Text(taskType.caption,
    //                     style: Theme.of(context).textTheme.bodyMedium),
    //                 heightSizedBox(20.0),
    //                 Align(
    //                     alignment: Alignment.center,
    //                     child: Icon(taskType.icon,
    //                         size: 100, color: taskType.color)),
    //                 // heightSizedBox(10.0),
    //               ])),
    //     ),
    //   ),
    // );
  }
}

class TaskType {
  final String title;
  final String caption;
  final IconData icon;
  final Widget widget;
  final Color color; // New color variable

  TaskType({
    required this.title,
    required this.caption,
    required this.icon,
    required this.widget,
    required this.color, // Required color parameter
  });
}

List<TaskType> taskTypes = [
  TaskType(
    title: "All Tasks",
    caption: "View all tasks in one place",
    icon: Icons.list,
    widget: const AllTaskScreen(),
    color: Colors.blue, // Color for All Tasks
  ),
  TaskType(
    title: "Pending Tasks",
    caption: "Tasks that are not completed yet",
    icon: Icons.pending_actions,
    widget: const PendingTaskScreen(),
    color: Colors.orange, // Color for Pending Tasks
  ),
  TaskType(
    title: "Completed Tasks",
    caption: "Tasks you have finished",
    icon: Icons.check_circle,
    widget: const CompletedTaskScreen(),
    color: Colors.green, // Color for Completed Tasks
  ),
  TaskType(
    title: "Today’s Tasks",
    caption: "Tasks scheduled for today",
    icon: Icons.calendar_today,
    widget: const TodayTaskScreen(),
    color: Colors.purple, // Color for Today’s Tasks
  ),
];
