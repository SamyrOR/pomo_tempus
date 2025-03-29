import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomo_tempus/data/services/theme_service.dart';
import 'package:pomo_tempus/domain/models/settings.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import '../../../data/repositories/settings_repository.dart';
import '../../../utils/result.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  HomeViewModel({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  //Timers
  Duration focusTimer = Duration(minutes: 25);
  Duration shortBreakTimer = Duration(minutes: 5);
  Duration longBreakTimer = Duration(minutes: 15);
  Duration minuteInSeconds = Duration(seconds: 0);
  late Duration actualTimer = focusTimer;

  //Strings
  String _focusString = 'focus';
  String _focusTimeString = 'Focus time';
  String _shortBreakString = 'shortBreak';
  String _shortBreakTimeString = 'Short break time';
  String _longBreakString = 'longBreak';
  String _longBreakTimeString = 'Long break time';
  String _restString = 'rest';
  String _applicationID = 'pomo_tempus';
  late String actualTimerString = _focusString;

  //Others
  Color pickerColor = Colors.amber;
  int cyclesCounter = 0;
  bool isPlaying = false;
  bool isNotificationEnabled = true;

  //Notifier
  late final _winNotifyPlugin = WindowsNotification(
    applicationId: _applicationID,
  );
  late NotificationMessage _message = NotificationMessage.fromPluginTemplate(
    _focusString,
    '',
    _focusTimeString,
  );

  //Theme
  final themeService = ThemeService.instance;

  Future<void> init() async {
    final settings = await _settingsRepository.getSettings();
    switch (settings) {
      case Ok<Settings?>():
        if (settings.value != null) {
          _updateInnerData(
            focusTime: settings.value!.focusTime,
            shortBreak: settings.value!.shortBreak,
            longBreak: settings.value!.longBreak,
            themeColor: settings.value!.themeColor,
            notificationEnabled: settings.value!.isNotificationEnabled,
          );
          themeService.updateTheme(pickerColor);
          notifyListeners();
        } else {
          themeService.updateTheme(pickerColor);
          actualTimer = focusTimer;
          final resultSave = await _settingsRepository.saveSettings(
            Settings(
              focusTime: focusTimer.inMinutes,
              shortBreak: shortBreakTimer.inMinutes,
              longBreak: longBreakTimer.inMinutes,
              isNotificationEnabled: isNotificationEnabled,
              themeColor: pickerColor,
            ),
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
    await _decrementTimer();
    notifyListeners();
  }

  Future<void> _decrementTimer() async {
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
          notifyListeners();
        } else {
          minuteInSeconds -= Duration(seconds: 1);
          notifyListeners();
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> nextTimer() async {
    if (cyclesCounter > 0 && cyclesCounter % 4 == 0) {
      _updateNextTimer(
        actual: longBreakTimer,
        actualString: _longBreakString,
        pluginId: _restString,
        pluginText: _longBreakTimeString,
      );
      cyclesCounter = 0;
    } else if (actualTimerString == _focusString) {
      _updateNextTimer(
        actual: shortBreakTimer,
        actualString: _shortBreakString,
        pluginId: _restString,
        pluginText: _shortBreakTimeString,
      );
    } else if (actualTimerString == _shortBreakString ||
        actualTimerString == _longBreakString) {
      _updateNextTimer(
        actual: focusTimer,
        actualString: _focusString,
        pluginId: _focusString,
        pluginText: _focusTimeString,
      );
      cyclesCounter++;
    }
    await _winNotifyPlugin.showNotificationPluginTemplate(_message);
    notifyListeners();
  }

  void changeSettings(Settings settings) async {
    focusTimer = Duration(minutes: settings.focusTime);
    shortBreakTimer = Duration(minutes: settings.shortBreak);
    longBreakTimer = Duration(minutes: settings.longBreak);
    pickerColor = settings.themeColor;
    themeService.updateTheme(pickerColor);
    if (actualTimerString == _focusString) {
      actualTimer = focusTimer;
    } else if (actualTimerString == _shortBreakString) {
      actualTimer = shortBreakTimer;
    } else if (actualTimerString == _longBreakString) {
      actualTimer = longBreakTimer;
    }
    minuteInSeconds = Duration(seconds: 0);
    final resultSave = await _settingsRepository.saveSettings(settings);
    notifyListeners();
    switch (resultSave) {
      case Ok<void>():
        break;
      case Error<void>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void handleNotificationToggle(value) {
    isNotificationEnabled = value;
    notifyListeners();
  }

  void handlePickColorSelect(Color color) {
    pickerColor = color;
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

  void _updateInnerData({
    required int focusTime,
    required int shortBreak,
    required int longBreak,
    required Color themeColor,
    required bool notificationEnabled,
  }) {
    focusTimer = Duration(minutes: focusTime);
    shortBreakTimer = Duration(minutes: shortBreak);
    longBreakTimer = Duration(minutes: longBreak);
    actualTimer = focusTimer;
    pickerColor = themeColor;
    isNotificationEnabled = notificationEnabled;
  }

  void _updateNextTimer({
    required Duration actual,
    required String actualString,
    required String pluginId,
    required String pluginText,
  }) {
    actualTimer = actual;
    actualTimerString = actualString;
    isPlaying = false;
    minuteInSeconds = Duration(seconds: 0);
    _message = NotificationMessage.fromPluginTemplate(pluginId, '', pluginText);
  }
}
