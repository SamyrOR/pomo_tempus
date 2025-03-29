import 'package:flutter/material.dart';

class ThemeHandler {
  static ThemeHandler? _instance;

  static ThemeHandler get instance {
    _instance ??= ThemeHandler._init();
    return _instance!;
  }

  ThemeHandler._init();

  ValueNotifier<ColorScheme> themeNotifier = ValueNotifier<ColorScheme>(
    ColorScheme.fromSeed(seedColor: Colors.amberAccent),
  );

  void updateTheme(Color newTheme) {
    themeNotifier.value = ColorScheme.fromSeed(seedColor: newTheme);
  }
}
