import 'package:flutter/material.dart';

class ThemeService {
  static ThemeService? _instance;

  static ThemeService get instance {
    _instance ??= ThemeService._init();
    return _instance!;
  }

  ThemeService._init();

  ValueNotifier<ColorScheme> themeNotifier = ValueNotifier<ColorScheme>(
    ColorScheme.fromSeed(seedColor: Colors.white),
  );

  void updateTheme(Color newTheme) {
    themeNotifier.value = ColorScheme.fromSeed(seedColor: newTheme);
  }
}
