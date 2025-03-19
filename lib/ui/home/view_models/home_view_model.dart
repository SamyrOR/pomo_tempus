import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  HomeViewModel();

  final focusTimer = Duration(minutes: 25);
  final shortBreakTimer = Duration(minutes: 5);
  final longBreakTimer = Duration(minutes: 15);

  final minuteInSeconds = Duration(seconds: 0);
  bool isPlaying = false;

  void play() {
    isPlaying = !isPlaying;
    print(isPlaying);
    notifyListeners();
  }
}
