import 'package:shared_preferences/shared_preferences.dart';

/// class to use the shared_preferences package easier
class SharedPreferencesService {
  /// method to clear every data in shared_preferences
  void clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// method to set an int
  void setInt(String value, int key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(value, key);
  }

  /// method to get an int
  Future<int?> getInt(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(value);
  }

  /// method to set a bool
  void setBool(String value, bool key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(value, key);
  }

  /// method to get a bool
  Future<bool?> getBool(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(value);
  }

  /// method to set a string
  void setString(String value, String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(value, key);
  }

  /// method to get a string
  Future<String?> getString(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(value);
  }

  /// method to check if a key is existent in shared_preferences
  Future<bool> containsKey(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(value);
  }
}