import 'dart:developer';

import '../export.dart';

final secureStorageProvider =
    Provider.autoDispose<SecureDatabase>((ref) => SecureDatabase());

class SecureDatabase {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
    log("Data written to key: $key, value: $value");
  }

  Future readData(String key) async {
    String value = await storage.read(key: key) ?? '';
    log("Data read from key: $key, value: $value");
    return value;
  }

  Future deleteData(String key) async {
    await storage.delete(key: key);
  }

  Future clearData() async {
    await storage.deleteAll();
  }
}
