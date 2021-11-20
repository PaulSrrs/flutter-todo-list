import 'package:doing/constants/shared_preferences.dart';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:flutter/material.dart';

/// class that handle the different theme_mode
class ThemeModelService extends ChangeNotifier {
  late bool _isDark;
  bool get isDark => _isDark;

  /// initializer that will set the theme when first called
  ThemeModelService(bool initialDark) {
    _isDark = initialDark;
  }

  /// method that set the theme in function of the [value] parameter
  setTheme(bool value) async {
    SharedPreferencesService().setBool(AppSharedPreferences.theme, value);
    _isDark = value;
    notifyListeners();
  }

  ///method that get the actual theme
  static getTheme() async {
    return await SharedPreferencesService().getBool(AppSharedPreferences.theme);
  }
}