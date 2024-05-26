import 'package:flutter/material.dart';

import 'darkmode.dart';
import 'lightmode.dart';

class ThemeProvider extends ChangeNotifier {
  //INITIAL VALUE OF THEME DATA IS LIGHTMODE
  ThemeData _themeData = lightMode;

  //GETTER METHOD TO ACCESS THEMEDATA
  ThemeData get themeData => _themeData;

  //GETTER METHOD TO SEE WHETEHER WE ARE IN DARK MODE OR NOT
  bool get isDarkMode => _themeData == darkMode;

  //SETTER METHOD TO SET NEW THEME
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //TOGGLE METHOD TO TOGGLE THE THEME
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
