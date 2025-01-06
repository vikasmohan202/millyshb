import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _theme = ThemeData.dark();

  // Getter for _theme
  ThemeData get theme => _theme;

  // Method to set dark mode
  void setDarkMode() {
    _theme = ThemeData.dark();
    notifyListeners();
  }

  // Method to set light mode
  void setLightMode() {
    _theme = ThemeData.light();
    notifyListeners();
  }

  // Setter for _theme
  set theme(ThemeData newTheme) {
    _theme = newTheme;
    notifyListeners(); // Notify listeners about the change
  }
}
