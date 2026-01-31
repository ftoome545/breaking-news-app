import 'package:flutter/material.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';
import 'package:my_app/theme/theme.dart';

import '../constants.dart';

enum AppTheme { light, dark }

class ThemeProvider with ChangeNotifier {
  AppTheme _currentTheme = AppTheme.light;

  ThemeProvider() {
    _initializeTheme();
  }

  ThemeData get themeData {
    return _currentTheme == AppTheme.light ? lightMode : darkMode;
  }

  void toggleTheme() {
    _currentTheme =
        _currentTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    bool isLight = _currentTheme == AppTheme.light;
    SharedPreferencesService.setBool(kthemeData, isLight);
    notifyListeners();
  }

  void setSystemTheme(Brightness brightness) {
    _currentTheme =
        brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
    notifyListeners();
  }

  void _initializeTheme() {
    final bool isLight = SharedPreferencesService.getBool(kthemeData);

    if (isLight == true) {
      _currentTheme = AppTheme.light;
    } else {
      _currentTheme = AppTheme.dark;
    }
  }
}
