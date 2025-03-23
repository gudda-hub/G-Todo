import 'dart:convert';
import 'dart:developer';
import '../export.dart';

final apiRespProvider = Provider.autoDispose((ref) {
  return ApiMethod(ref);
});

// GetAll Task , create Task , delete Task , Update Task Status
class ApiMethod {
  final AutoDisposeProviderRef<Object?> ref;
  ApiMethod(this.ref);
  Future<Respond> retrieveAll() async {
    try {
      dynamic getData =
          await ref.watch(secureStorageProvider).readData(DbUrls.task);
      if (getData.isEmpty) {
        return Respond(message: Msg.noTasksAvailable, data: [], success: true);
      } else {
        List data = jsonDecode(getData);
        log("Get Data : $data");
        return Respond(message: Msg.successFull, data: data, success: true);
      }
    } catch (e) {
      log("Retrieve resp fn Error :$e");
      return Respond(message: Msg.errorMsg, data: null, success: false);
    }
  }

  Future<Respond> create(TaskModel taskModel) async {
    try {
      log("In Resp FInal Data :${taskModel.toJson()}");
      dynamic getData =
          await ref.watch(secureStorageProvider).readData(DbUrls.task);
      if (getData.isEmpty) {
        List data = [];
        data.add(taskModel.toJson());
        await ref
            .watch(secureStorageProvider)
            .writeData(key: DbUrls.task, value: jsonEncode(data));
        return Respond(message: Msg.taskAdded, data: null, success: true);
      } else {
        List allTask = jsonDecode(getData);
        log("check 1: $allTask");
        log("check 2: ${taskModel.toJson()}");
        allTask.add(taskModel.toJson());
        allTask = allTask;
        log("check 3: ${jsonEncode(allTask)}");
        await ref
            .watch(secureStorageProvider)
            .writeData(key: DbUrls.task, value: jsonEncode(allTask));
        ref.invalidate(secureStorageProvider);
        return Respond(message: Msg.taskAdded, data: null, success: true);
      }
    } catch (e) {
      log("Create resp fn Error :$e");
      return Respond(message: Msg.taskAddFailed, data: null, success: false);
    }
  }

  Future<Respond> update(String taskId) async {
    try {
      dynamic getData =
          await ref.watch(secureStorageProvider).readData(DbUrls.task);
      List allTask = jsonDecode(getData);
      log("Before Update - Data: $allTask");
      for (var task in allTask) {
        if (task['taskId'] == taskId) {
          log("match");
          task['isCompleted'] = !task['isCompleted'];
          if (task['status'] == 'Completed') {
            task['status'] = 'Pending';
          } else {
            task['status'] = 'Completed';
          }
        }
      }

      log("After Update - Data: ${jsonEncode(allTask)}");
      await ref
          .watch(secureStorageProvider)
          .writeData(key: DbUrls.task, value: jsonEncode(allTask));
      ref.invalidate(secureStorageProvider);
      return Respond(message: Msg.taskUpdated, data: null, success: true);
    } catch (e) {
      log("Delete Error: $e");
      return Respond(message: Msg.taskUpdateFailed, data: null, success: false);
    }
  }

  Future<Respond> delete(String taskId) async {
    try {
      dynamic getData =
          await ref.watch(secureStorageProvider).readData(DbUrls.task);
      List allTask = jsonDecode(getData);
      log("Before Delete - Data: $allTask");
      allTask.removeWhere((task) => task['taskId'] == taskId);
      log("After Delete - Data: ${jsonEncode(allTask)}");
      await ref
          .watch(secureStorageProvider)
          .writeData(key: DbUrls.task, value: jsonEncode(allTask));
      ref.invalidate(secureStorageProvider);
      return Respond(message: Msg.taskDeleted, data: null, success: true);
    } catch (e) {
      log("Delete Error: $e");
      return Respond(message: Msg.taskDeleteFailed, data: null, success: false);
    }
  }
}
