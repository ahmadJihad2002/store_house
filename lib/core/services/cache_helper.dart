import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print('sharedPreferences');
    print(sharedPreferences);
  }

  static Future<String> getData({required String key}) async {
    return sharedPreferences?.getString(key) ?? '';
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {

    if (sharedPreferences!=null) {
      if (value is bool) return await sharedPreferences!.setBool(key, value);
      if (value is String) return await sharedPreferences!.setString(key, value);
      if (value is int) return await sharedPreferences!.setInt(key, value);
      if (value is double) return await sharedPreferences!.setDouble(key, value);
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  static removeData({required String key}) async {
    return sharedPreferences?.remove(key);
  }
}



