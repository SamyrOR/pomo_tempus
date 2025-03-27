// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Settings {

 int get pomodoro; int get shortBreak; int get longBreak; bool get isNotificationEnabled; Color get themeColor;
/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsCopyWith<Settings> get copyWith => _$SettingsCopyWithImpl<Settings>(this as Settings, _$identity);

  /// Serializes this Settings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settings&&(identical(other.pomodoro, pomodoro) || other.pomodoro == pomodoro)&&(identical(other.shortBreak, shortBreak) || other.shortBreak == shortBreak)&&(identical(other.longBreak, longBreak) || other.longBreak == longBreak)&&(identical(other.isNotificationEnabled, isNotificationEnabled) || other.isNotificationEnabled == isNotificationEnabled)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pomodoro,shortBreak,longBreak,isNotificationEnabled,themeColor);

@override
String toString() {
  return 'Settings(pomodoro: $pomodoro, shortBreak: $shortBreak, longBreak: $longBreak, isNotificationEnabled: $isNotificationEnabled, themeColor: $themeColor)';
}


}

/// @nodoc
abstract mixin class $SettingsCopyWith<$Res>  {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) _then) = _$SettingsCopyWithImpl;
@useResult
$Res call({
 int pomodoro, int shortBreak, int longBreak, bool isNotificationEnabled, Color themeColor
});




}
/// @nodoc
class _$SettingsCopyWithImpl<$Res>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._self, this._then);

  final Settings _self;
  final $Res Function(Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pomodoro = null,Object? shortBreak = null,Object? longBreak = null,Object? isNotificationEnabled = null,Object? themeColor = null,}) {
  return _then(_self.copyWith(
pomodoro: null == pomodoro ? _self.pomodoro : pomodoro // ignore: cast_nullable_to_non_nullable
as int,shortBreak: null == shortBreak ? _self.shortBreak : shortBreak // ignore: cast_nullable_to_non_nullable
as int,longBreak: null == longBreak ? _self.longBreak : longBreak // ignore: cast_nullable_to_non_nullable
as int,isNotificationEnabled: null == isNotificationEnabled ? _self.isNotificationEnabled : isNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// @nodoc
@JsonSerializable()
@_ColorConverter()
class _Settings implements Settings {
  const _Settings({required this.pomodoro, required this.shortBreak, required this.longBreak, required this.isNotificationEnabled, required this.themeColor});
  factory _Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

@override final  int pomodoro;
@override final  int shortBreak;
@override final  int longBreak;
@override final  bool isNotificationEnabled;
@override final  Color themeColor;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsCopyWith<_Settings> get copyWith => __$SettingsCopyWithImpl<_Settings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settings&&(identical(other.pomodoro, pomodoro) || other.pomodoro == pomodoro)&&(identical(other.shortBreak, shortBreak) || other.shortBreak == shortBreak)&&(identical(other.longBreak, longBreak) || other.longBreak == longBreak)&&(identical(other.isNotificationEnabled, isNotificationEnabled) || other.isNotificationEnabled == isNotificationEnabled)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pomodoro,shortBreak,longBreak,isNotificationEnabled,themeColor);

@override
String toString() {
  return 'Settings(pomodoro: $pomodoro, shortBreak: $shortBreak, longBreak: $longBreak, isNotificationEnabled: $isNotificationEnabled, themeColor: $themeColor)';
}


}

/// @nodoc
abstract mixin class _$SettingsCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$SettingsCopyWith(_Settings value, $Res Function(_Settings) _then) = __$SettingsCopyWithImpl;
@override @useResult
$Res call({
 int pomodoro, int shortBreak, int longBreak, bool isNotificationEnabled, Color themeColor
});




}
/// @nodoc
class __$SettingsCopyWithImpl<$Res>
    implements _$SettingsCopyWith<$Res> {
  __$SettingsCopyWithImpl(this._self, this._then);

  final _Settings _self;
  final $Res Function(_Settings) _then;

/// Create a copy of Settings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pomodoro = null,Object? shortBreak = null,Object? longBreak = null,Object? isNotificationEnabled = null,Object? themeColor = null,}) {
  return _then(_Settings(
pomodoro: null == pomodoro ? _self.pomodoro : pomodoro // ignore: cast_nullable_to_non_nullable
as int,shortBreak: null == shortBreak ? _self.shortBreak : shortBreak // ignore: cast_nullable_to_non_nullable
as int,longBreak: null == longBreak ? _self.longBreak : longBreak // ignore: cast_nullable_to_non_nullable
as int,isNotificationEnabled: null == isNotificationEnabled ? _self.isNotificationEnabled : isNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
