import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsServices {
  ///TODO: modify the code as per the need
  ///
  /// ### initialize SharedPreferences
  /// ------------------------
  /// call initialize() method to initialize SharedPreferences instance
  ///
  /// ```
  /// Example:
  /// Future<void> main()async{
  ///   await SharedPrefsServices.instance.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///

  late SharedPreferences sharedPreferences;
  static SharedPrefsServices instance = SharedPrefsServices._internal();

  factory SharedPrefsServices() {
    return instance;
  }

  Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///------------------Sample  Set method--------------------------
  Future<bool> setValue(String token) async {
    return await sharedPreferences.setString(StorageKeys.key, token);
  }

  ///------------------Sample  Get methods-------------------------
  String? getValue() {
    return sharedPreferences.getString(StorageKeys.key);
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }

  Future<void> setThemeMode(bool isDark) async {
    await sharedPreferences.setBool(StorageKeys.themeMode, isDark);
  }

  bool? getThemeMode() {
    return sharedPreferences.getBool(StorageKeys.themeMode);
  }

  SharedPrefsServices._internal();
}

class StorageKeys {
  static const key = "key";
  static const themeMode = "theme_mode";
}
