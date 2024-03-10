import 'package:get_storage/get_storage.dart';

abstract class LocalClient {
  Future<void> saveData(String key, dynamic value);
  Future<void> removeData(String key);
  Future<void> removeAll();
  T readData<T>(String key);
  bool hasData<T>(String key);
}

class LocalClientImpl implements LocalClient {
  final box = GetStorage();

  @override
  Future<void> saveData(String key, dynamic value) async {
    return await box.write(key, value);
  }

  @override
  Future<void> removeData(String key) async {
    return await box.remove(key);
  }

  @override
  T readData<T>(String key) {
    return box.read(key);
  }

  @override
  bool hasData<T>(String key) {
    return box.hasData(key);
  }

  @override
  Future<void> removeAll() {
    return box.erase();
  }
}
