import 'package:flutter/material.dart';

class ModeController extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}