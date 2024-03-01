import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> saveAccessToken(dynamic value);
  Future<void> saveRefreshToken(dynamic value);
  Future<String?> getRefreshToken();
  Future<bool> hasToken();
  Future<void> saveUserId(dynamic value);
  Future<String?> getUserId();
  void removeAll();
  Future<void> removeAllAsync();
}

class SecureStorageImpl implements SecureStorage {
  /// Define secure storage
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<void> saveAccessToken(dynamic value) async {
    return await secureStorage.write(key: Constants.access_token, value: value);
  }

  @override
  Future<void> saveRefreshToken(dynamic value) async {
    return await secureStorage.write(
        key: Constants.refresh_token, value: value);
  }

  @override
  Future<String?> getRefreshToken() {
    return secureStorage.read(key: Constants.refresh_token);
  }

  @override
  Future<bool> hasToken() async {
    bool hasToken =
        await secureStorage.containsKey(key: Constants.access_token);
    return hasToken;
  }

  @override
  Future<void> saveUserId(dynamic value) async {
    return await secureStorage.write(key: Constants.id, value: value);
  }

  @override
  Future<String?> getUserId() {
    return secureStorage.read(key: Constants.id);
  }

  @override
  void removeAll() async {
    await secureStorage.deleteAll();
  }

  @override
  Future<void> removeAllAsync() async {
    await secureStorage.deleteAll();
  }
}
