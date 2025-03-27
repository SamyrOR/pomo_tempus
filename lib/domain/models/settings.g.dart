// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  pomodoro: (json['pomodoro'] as num).toInt(),
  shortBreak: (json['shortBreak'] as num).toInt(),
  longBreak: (json['longBreak'] as num).toInt(),
  isNotificationEnabled: json['isNotificationEnabled'] as bool,
  themeColor: const _ColorConverter().fromJson(
    (json['themeColor'] as num).toInt(),
  ),
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'pomodoro': instance.pomodoro,
  'shortBreak': instance.shortBreak,
  'longBreak': instance.longBreak,
  'isNotificationEnabled': instance.isNotificationEnabled,
  'themeColor': const _ColorConverter().toJson(instance.themeColor),
};
