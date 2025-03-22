import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

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
  final winNotifyPlugin = WindowsNotification(applicationId: 'pomo_tempus');
  NotificationMessage message = NotificationMessage.fromPluginTemplate(
    "focus",
    "",
    "Focus time",
  );
  bool isPlaying = false;
  bool isNotificationEnabled = true;

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
          minuteInSeconds = Duration(seconds: 5);
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

  void nextTimer() async {
    if (cyclesCounter > 0 && cyclesCounter % 4 == 0) {
      actualTimer = longBreakTimer;
      actualTimerString = 'longBreak';
      isPlaying = false;
      minuteInSeconds = Duration(seconds: 0);
      cyclesCounter = 0;
      message = NotificationMessage.fromPluginTemplate(
        "rest",
        "",
        "Long break time",
      );
    } else if (actualTimerString == 'focus') {
      actualTimer = shortBreakTimer;
      actualTimerString = 'shortBreak';
      isPlaying = false;
      minuteInSeconds = Duration(seconds: 0);
      message = NotificationMessage.fromPluginTemplate(
        "rest",
        "",
        "Short break time",
      );
    } else if (actualTimerString == 'shortBreak' ||
        actualTimerString == 'longBreak') {
      actualTimer = focusTimer;
      actualTimerString = 'focus';
      isPlaying = false;
      cyclesCounter++;
      minuteInSeconds = Duration(seconds: 0);
      message = NotificationMessage.fromPluginTemplate(
        "focus",
        "",
        "Focus time",
      );
    }
    await winNotifyPlugin.showNotificationPluginTemplate(message);
    notifyListeners();
  }

  // formatTimer(Duration actualTime) {
  //   formattedTimer =
  //       '${actualTimer.inMinutes < 10 ? '0' : ''}${actualTimer.inMinutes} : ${minuteInSeconds.inSeconds < 10 ? '0' : ''}${minuteInSeconds.inSeconds}';
  // }
}
