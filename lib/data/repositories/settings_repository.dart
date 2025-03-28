import 'package:pomo_tempus/domain/models/settings.dart';
import 'package:pomo_tempus/utils/result.dart';

import '../services/shared_preferences_service.dart';

class SettingsRepository {
  SettingsRepository({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;

  Future<Result<Settings?>> getSettings() async {
    return _sharedPreferencesService.getSettings();
  }

  Future<Result<void>> saveSettings(Settings settings) async {
    return _sharedPreferencesService.saveSettings(settings);
  }
}
