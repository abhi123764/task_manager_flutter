import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !isDark;
    notifyListeners();
  }

  Color get scaffoldColor => isDark ? Colors.black : Colors.white;
}
