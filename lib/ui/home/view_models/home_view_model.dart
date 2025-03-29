import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pomo_tempus/domain/models/settings.dart';
import 'package:pomo_tempus/theme_handler.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import '../../../data/repositories/settings_repository.dart';
import '../../../utils/result.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  HomeViewModel({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Duration focusTimer = Duration(minutes: 25);
  Duration shortBreakTimer = Duration(minutes: 5);
  Duration longBreakTimer = Duration(minutes: 15);
  Duration minuteInSeconds = Duration(seconds: 0);
  late Duration actualTimer = focusTimer;
  late Color pickerColor;
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
  late bool isNotificationEnabled;

  Future<void> init() async {
    final settings = await _settingsRepository.getSettings();
    switch (settings) {
      case Ok<Settings?>():
        if (settings.value != null) {
          focusTimer = Duration(minutes: settings.value!.focusTime);
          shortBreakTimer = Duration(minutes: settings.value!.shortBreak);
          longBreakTimer = Duration(minutes: settings.value!.longBreak);
          actualTimer = focusTimer;
          pickerColor = settings.value!.themeColor;
          ThemeHandler.instance.updateTheme(pickerColor);
          isNotificationEnabled = settings.value!.isNotificationEnabled;
          notifyListeners();
        } else {
          final initialSettings = Settings.initial();
          focusTimer = Duration(minutes: initialSettings.focusTime);
          shortBreakTimer = Duration(minutes: initialSettings.shortBreak);
          longBreakTimer = Duration(minutes: initialSettings.longBreak);
          pickerColor = initialSettings.themeColor;
          ThemeHandler.instance.updateTheme(pickerColor);
          actualTimer = focusTimer;
          isNotificationEnabled = initialSettings.isNotificationEnabled;
          final resultSave = await _settingsRepository.saveSettings(
            initialSettings,
          );
          notifyListeners();
          switch (resultSave) {
            case Ok<void>():
            case Error<void>():
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        }
      case Error<Settings?>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void play() async {
    isPlaying = !isPlaying;
    // print(isPlaying);
    await decrementTimer();
    notifyListeners();
  }

  void startTimer() {}

  Future<void> decrementTimer() async {
    //Code partially generated with help of Gemini IA of Google
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (isPlaying) {
        if (actualTimer.inSeconds == 0 && minuteInSeconds.inSeconds == 0) {
          timer.cancel();
          await nextTimer();
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

  Future<void> nextTimer() async {
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

  void changeSettings(Settings settings) async {
    focusTimer = Duration(minutes: settings.focusTime);
    shortBreakTimer = Duration(minutes: settings.shortBreak);
    longBreakTimer = Duration(minutes: settings.longBreak);
    pickerColor = settings.themeColor;
    ThemeHandler.instance.updateTheme(pickerColor);
    if (actualTimerString == 'focus') {
      actualTimer = focusTimer;
    } else if (actualTimerString == 'shortBreak') {
      actualTimer = shortBreakTimer;
    } else if (actualTimerString == 'longBreak') {
      actualTimer = longBreakTimer;
    }
    final resultSave = await _settingsRepository.saveSettings(settings);
    minuteInSeconds = Duration(seconds: 0);
    notifyListeners();
    switch (resultSave) {
      case Ok<void>():
        break;
      case Error<void>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void changeNotification(value) {
    isNotificationEnabled = value;
    notifyListeners();
  }

  void changeTheme(Color color) {
    pickerColor = color;
    // ThemeHandler.instance.updateTheme(pickerColor);
    notifyListeners();
  }

  Settings parseSettingsFromForm({
    required String focusTime,
    required String shortBreak,
    required String longBreak,
    required bool isNotificationEnabled,
    required Color themeColor,
  }) {
    return Settings(
      focusTime: int.parse(focusTime),
      shortBreak: int.parse(shortBreak),
      longBreak: int.parse(longBreak),
      isNotificationEnabled: isNotificationEnabled,
      themeColor: themeColor,
    );
  }

  // formatTimer(Duration actualTime) {
  //   formattedTimer =
  //       '${actualTimer.inMinutes < 10 ? '0' : ''}${actualTimer.inMinutes} : ${minuteInSeconds.inSeconds < 10 ? '0' : ''}${minuteInSeconds.inSeconds}';
  // }
}
