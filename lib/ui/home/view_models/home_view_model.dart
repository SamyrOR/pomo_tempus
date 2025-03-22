import 'dart:async';

import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  HomeViewModel();

  Duration focusTimer = Duration(minutes: 25);
  Duration shortBreakTimer = Duration(minutes: 5);
  Duration longBreakTimer = Duration(minutes: 15);
  Duration minuteInSeconds = Duration(seconds: 0);
  late Duration actualTimer = focusTimer;
  String actualTimerString = 'focus';
  int cyclesCounter = 0;
  // late String formattedTimer = formatTimer(actualTimer);

  bool isPlaying = false;

  void play() {
    isPlaying = !isPlaying;
    // print(isPlaying);
    decrementTimer();
    notifyListeners();
  }

  void decrementTimer() async {
    //Code partially generated with help of Gemini IA of Google
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPlaying) {
        if (actualTimer.inSeconds == 0 && minuteInSeconds.inSeconds == 0) {
          timer.cancel();
          nextTimer();
        }

        if (minuteInSeconds.inSeconds == 0) {
          actualTimer -= Duration(minutes: 1);
          minuteInSeconds = Duration(seconds: 59);
          // formatTimer(focusTimer);
          notifyListeners();
        } else {
          minuteInSeconds -= Duration(seconds: 1);
          // formatTimer(focusTimer);
          notifyListeners();
        }
      } else {
        timer.cancel();
      }
    });
  }

  void nextTimer() {
    if (cyclesCounter > 0 && cyclesCounter % 4 == 0) {
      actualTimer = longBreakTimer;
      actualTimerString = 'longBreak';
      isPlaying = false;
      minuteInSeconds = Duration(seconds: 0);
      cyclesCounter = 0;
    } else if (actualTimerString == 'focus') {
      actualTimer = shortBreakTimer;
      actualTimerString = 'shortBreak';
      isPlaying = false;
      minuteInSeconds = Duration(seconds: 0);
    } else if (actualTimerString == 'shortBreak' ||
        actualTimerString == 'longBreak') {
      actualTimer = focusTimer;
      actualTimerString = 'focus';
      isPlaying = false;
      cyclesCounter++;
      minuteInSeconds = Duration(seconds: 0);
    }
    notifyListeners();
  }

  // formatTimer(Duration actualTime) {
  //   formattedTimer =
  //       '${actualTimer.inMinutes < 10 ? '0' : ''}${actualTimer.inMinutes} : ${minuteInSeconds.inSeconds < 10 ? '0' : ''}${minuteInSeconds.inSeconds}';
  // }
}
