import 'dart:developer';

import 'package:todo/export.dart';

Future<String> getDeviceToken(WidgetRef ref) async {
  final storage = ref.watch(secureStorageProvider);
  log("getDeviceToken run");

  String? existingToken = await storage.readData(DbUrls.deviceToken);
  if (existingToken!.isNotEmpty) {
    log("Existing token: $existingToken");
    return existingToken; // Return the stored token
  }

  const uuid = Uuid();
  String newToken = uuid.v4(); // Generate a random token
  final deviceInfo = DeviceInfoPlugin();

  try {
    if (await deviceInfo.deviceInfo is AndroidDeviceInfo) {
      final androidInfo = await deviceInfo.androidInfo;
      newToken = androidInfo.id; // Use Android's unique ID
    } else if (await deviceInfo.deviceInfo is IosDeviceInfo) {
      final iosInfo = await deviceInfo.iosInfo;
      newToken =
          iosInfo.identifierForVendor ?? uuid.v4(); // Use iOS's unique ID
    }
  } catch (e) {
    log("Error getting device info: $e");
  }

  return newToken;
}
