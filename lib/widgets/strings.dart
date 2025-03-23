class Msg {
  // General Success Messages
  static String successFull = 'Operation completed successfully.';
  static String updateSuccessFullMsg = 'Task updated successfully.';
  static String deleteSuccessFullMsg = 'Task deleted successfully.';
  static String createSuccessFullMsg = 'Task added successfully.';
  static String completeSuccessFullMsg =
      'Task marked as completed successfully.';

  // General Error Messages
  static String errorMsg = 'An error occurred. Please try again later.';
  static String networkErrorMsg =
      'Unable to connect. Please check your internet connection.';
  static String validationErrorMsg = 'Please fill in all required fields.';
  static String uploadErrorMsg = 'Failed to save the task. Please try again.';

  // Specific Success Messages
  static String taskAdded = 'Task added successfully!';
  static String taskUpdated = 'Task updated successfully!';
  static String taskDeleted = 'Task deleted successfully!';
  static String taskCompleted = 'Task completed successfully!';
  static String taskReopened = 'Task reopened successfully!';

  // Specific Error Messages
  static String taskAddFailed = 'Failed to add the task. Please try again.';
  static String taskUpdateFailed = 'Failed to update the task.';
  static String taskDeleteFailed = 'Failed to delete the task.';
  static String taskCompleteFailed = 'Failed to mark the task as complete.';

  // User Feedback
  static String confirmDelete = 'Are you sure you want to delete this task?';
  static String noTasksAvailable =
      'No tasks available. Add a new one to get started.';
  static String priorityMissing = 'Please select a priority level.';
  static String statusMissing = 'Please select a task status.';
}
