import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  Color get scaffoldColor => isDark ? Colors.black : Colors.white;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
