import 'package:get_storage/get_storage.dart';

class LocalDatabase {
  final box = GetStorage();

  Future<void> saveData(String key, dynamic value) async {
    return await box.write(key, value);
  }

  Future<void> removeData(String key) async {
    return await box.remove(key);
  }

  T readData<T>(String key) {
    return box.read(key);
  }

  bool hasData<T>(String key) {
    return box.hasData(key);
  }
}
