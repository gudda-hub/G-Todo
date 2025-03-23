class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime dueDate;
  final DateTime createdDate;
  final DateTime updatedDate;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.createdDate,
    required this.updatedDate,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['taskId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      priority: map['priority'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      createdDate: DateTime.parse(map['createdDate']),
      updatedDate: DateTime.parse(map['updatedDate']),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}

Map<String, dynamic> taskMap = {
  "taskId": "12345",
  "title": "Complete Flutter Project",
  "description":
      "Finish the UI and API integration for the task management module.",
  "status": "pending",
  "priority": "high",
  "dueDate": "2025-01-20T18:00:00Z",
  "createdDate": "2025-01-18T12:00:00Z",
  "updatedDate": "2025-01-19T09:00:00Z",
  "isCompleted": false,
};

class Respond {
  final String message;
  final dynamic data;
  final bool success;

  Respond({required this.message, required this.data, required this.success});

  factory Respond.fromJson(Map<String, dynamic> json) {
    return Respond(
        message: json['message'], data: json['data'], success: json['success']);
  }
}
