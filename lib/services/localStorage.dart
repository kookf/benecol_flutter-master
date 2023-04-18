import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSingleton{
  static final LocalStorageSingleton _instance = LocalStorageSingleton._private();

  factory LocalStorageSingleton(){
    return _instance;
  }

  LocalStorageSingleton._private();

  Future<void> setValue(String key, dynamic value) async{
    // print('[LocalStorage]: saving $key with $value');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString(key, value);
  }

  Future<String?> getValue(String key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? value = await localStorage.getString(key);
    // print('[LocalStorage]: getting $key with $value');
    return value;
  }

  Future<bool?> removeValue(String key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool value = await localStorage.remove(key);
    // print('[LocalStorage]: getting $key with $value');
    return value;
  }
}
