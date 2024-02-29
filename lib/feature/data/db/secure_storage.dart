import 'package:cleaning_duty_project/core/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  /// Define secure storage
  final secureStorage = const FlutterSecureStorage();

  /// Define key
  final String accessToken = Constants.access_token;
  final String refreshToken = Constants.refresh_token;
  final String id = Constants.id;

  Future<void> saveToken(dynamic value) async {
    return await secureStorage.write(key: accessToken, value: value);
  }

  Future<String?> getToken() {
    return secureStorage.read(key: accessToken);
  }

  Future<bool> hasToken() async {
    bool hasToken = await secureStorage.containsKey(key: accessToken);
    return hasToken;
  }

  Future<void> saveUserId(dynamic value) async {
    return await secureStorage.write(key: id, value: value);
  }

  Future<String?> getUserId() {
    return secureStorage.read(key: id);
  }

  Future<void> saveAll(dynamic token, dynamic id) async {
    await saveToken(token);
    await saveUserId(id);
  }

  void removeAll() async {
    await secureStorage.deleteAll();
  }

  Future<void> removeAllAsync() async {
    await secureStorage.deleteAll();
  }
}
