import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  /// Define secure storage
  final secureStorage = const FlutterSecureStorage();

  Future<void> saveAccessToken(dynamic value) async {
    return await secureStorage.write(key: Constants.access_token, value: value);
  }

  Future<void> saveRefreshToken(dynamic value) async {
    return await secureStorage.write(
        key: Constants.refresh_token, value: value);
  }

  Future<String?> getRefreshToken() {
    return secureStorage.read(key: Constants.refresh_token);
  }

  Future<bool> hasToken() async {
    bool hasToken =
        await secureStorage.containsKey(key: Constants.access_token);
    return hasToken;
  }

  Future<void> saveUserId(dynamic value) async {
    return await secureStorage.write(key: Constants.id, value: value);
  }

  Future<String?> getUserId() {
    return secureStorage.read(key: Constants.id);
  }

  void removeAll() async {
    await secureStorage.deleteAll();
  }

  Future<void> removeAllAsync() async {
    await secureStorage.deleteAll();
  }
}
