import '../../export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const List<String> statusOptions = ['Pending', 'In Progress', 'Completed'];
const List<String> priorityOptions = ['Low', 'Medium', 'High', 'Critical'];
const List<String> isCompletedOptions = ['Yes', 'No'];

class TaskBackGroundPage extends ConsumerWidget {
  final Widget? child;
  final String appBarTitle;

  const TaskBackGroundPage({super.key, this.child, required this.appBarTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(isDarkModeProvider);
    return Container(
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height * 1,
        color: isDarkMode ? ColorTheme.primaryDark : ColorTheme.primaryLight,
        child: Column(children: [
          AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(appBarTitle)),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 14.0)
                      .copyWith(top: 30),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60.0)),
                      color: ColorTheme.getBackground(isDarkMode)),
                  child: child))
        ]));
  }
}

// class TaskChip extends StatelessWidget {
//   final TaskModel task;
//   final VoidCallback onDelete;
//   final VoidCallback onStatusToggle;

//   const TaskChip({
//     super.key,
//     required this.onDelete,
//     required this.onStatusToggle,
//     required this.task,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Assign color based on priority
//     Color priorityColor = Colors.green;
//     if (task.priority.toLowerCase() == "high") {
//       priorityColor = Colors.red;
//     } else if (task.priority.toLowerCase() == "medium") {
//       priorityColor = Colors.orange;
//     }
//     // Status label
//     String statusLabel = 'Pending'; // Default status
//     Color statusColor = Colors.yellow; // Default color for Pending
//     if (task.status.toLowerCase() == 'pending') {
//       statusLabel = 'Completed';
//       statusColor = Colors.green; // Completed status color
//     } else if (task.status.toLowerCase() == 'in progress') {
//       statusLabel = 'In Progress';
//       statusColor = Colors.blue; // In Progress status color
//     }

//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Slidable(
//         key: const ValueKey(0),
//         endActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           children: [
//             SlidableAction(
//                 borderRadius: BorderRadius.circular(14),
//                 onPressed: (_) => onDelete(),
//                 backgroundColor: const Color(0xFFFE4A49), // Red for delete
//                 foregroundColor: Colors.white,
//                 icon: Icons.delete,
//                 label: 'Delete'),
//           ],
//         ),
//         // The main content (task details)
//         child: Card(
//           elevation: 1,
//           child: ListTile(
//             contentPadding: const EdgeInsets.all(16.0),
//             leading: CircleAvatar(
//                 backgroundColor: priorityColor,
//                 child: Icon(
//                     task.priority == "high"
//                         ? Icons.priority_high
//                         : Icons.access_alarm,
//                     color: Colors.white)),
//             title: Text(
//               task.title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 decoration: task.isCompleted
//                     ? TextDecoration.lineThrough
//                     : TextDecoration.none,
//               ),
//             ),
//             subtitle: Text(task.description),
//             trailing: IconButton(
//               icon: Icon(
//                 task.isCompleted
//                     ? Icons.check_circle
//                     : Icons.radio_button_unchecked,
//                 color: task.isCompleted ? Colors.green : Colors.grey,
//               ),
//               onPressed: onStatusToggle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class TaskChip extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onStatusToggle;

  const TaskChip({
    super.key,
    required this.onDelete,
    required this.onStatusToggle,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    // Assign color based on priority
    Color priorityColor = Colors.green;
    if (task.priority.toLowerCase() == "high") {
      priorityColor = Colors.red;
    } else if (task.priority.toLowerCase() == "medium") {
      priorityColor = Colors.orange;
    }

    // Status label
    String statusLabel = 'Pending'; // Default status
    Color statusColor = Colors.yellow; // Default color for Pending
    if (task.status.toLowerCase() == 'completed') {
      statusLabel = 'Completed';
      statusColor = Colors.green; // Completed status color
    } else if (task.status.toLowerCase() == 'in progress') {
      statusLabel = 'In Progress';
      statusColor = Colors.blue; // In Progress status color
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                borderRadius: BorderRadius.circular(14),
                onPressed: (_) => onDelete(),
                backgroundColor: const Color(0xFFFE4A49), // Red for delete
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete'),
          ],
        ),
        // The main content (task details)
        child: Card(
          elevation: 1,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: CircleAvatar(
              backgroundColor: priorityColor,
              child: Icon(
                task.priority == "high"
                    ? Icons.priority_high
                    : Icons.access_alarm,
                color: Colors.white,
              ),
            ),
            title: Text(
              capitalizeFirstLetter(task.title),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Status toggle icon
                IconButton(
                  icon: Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),
                  onPressed: onStatusToggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
