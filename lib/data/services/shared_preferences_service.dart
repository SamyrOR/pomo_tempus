import 'dart:convert';

import 'package:pomo_tempus/domain/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/result.dart';

class SharedPreferencesService {
  Future<Result<Settings?>> getSettings() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final settingsJson = sharedPreferences.getString('settings');
      if (settingsJson == null) {
        return Result.ok(null);
      }
      return Result.ok(Settings.fromJson(jsonDecode(settingsJson)));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> saveSettings(Settings settings) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(
        'settings',
        jsonEncode(settings.toJson()),
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
