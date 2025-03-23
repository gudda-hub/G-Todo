import '../export.dart';

final btnEnableProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final isDarkModeProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final authenticationProvider = StateProvider.autoDispose((ref) async {
  String token =
      await ref.watch(secureStorageProvider).readData(DbUrls.deviceToken);
  if (token.isNotEmpty) {
    navigatePushReplacement(const HomeScreen());
  } else {
    navigatePushReplacement(const OnBoardingScreen());
  }
});

final allTaskGetProvider = FutureProvider.autoDispose((ref) async {
  Respond respond = await ref.watch(apiRespProvider).retrieveAll();
  if (respond.success) {
    return respond.data;
  } else {
    snackBarMsg(respond.message);
  }
});

final apiControllerProvider = Provider.autoDispose((ref) {
  final resp = ref.watch(apiRespProvider);
  return ApiController(ref, resp);
});

class ApiController {
  final AutoDisposeProviderRef<Object?> ref;
  final ApiMethod resp;
  ApiController(this.ref, this.resp);

  create(TaskModel taskModel) async {
    Respond respond = await resp.create(taskModel);
    if (respond.success) {
      ref.invalidate(allTaskGetProvider);
      navigateToRemoveUntil(const HomeScreen());
      snackBarMsg(respond.message);
    } else {
      snackBarMsg(respond.message);
    }
  }

  update(String taskId) async {
    Respond respond = await resp.update(taskId);
    if (respond.success) {
      ref.invalidate(allTaskGetProvider);
      snackBarMsg(respond.message);
    } else {
      snackBarMsg(respond.message);
    }
  }

  delete(String taskId) async {
    Respond respond = await resp.delete(taskId);
    if (respond.success) {
      ref.invalidate(allTaskGetProvider);
      snackBarMsg(respond.message);
    } else {
      snackBarMsg(respond.message);
    }
  }
}
