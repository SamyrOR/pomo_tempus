import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
abstract class Settings with _$Settings {
  @_ColorConverter()
  const factory Settings({
    required int pomodoro,
    required int shortBreak,
    required int longBreak,
    required bool isNotificationEnabled,
    required Color themeColor,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  factory Settings.initial() => Settings(
    pomodoro: 25,
    shortBreak: 5,
    longBreak: 15,
    isNotificationEnabled: true,
    themeColor: Colors.amber,
  );
}

class _ColorConverter implements JsonConverter<Color, int> {
  const _ColorConverter();

  @override
  Color fromJson(int json) {
    return Color(json);
  }

  @override
  int toJson(Color object) {
    return object.toARGB32();
  }
}
