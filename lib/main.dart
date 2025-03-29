import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomo_tempus/data/repositories/settings_repository.dart';
import 'package:pomo_tempus/data/services/shared_preferences_service.dart';
import 'package:pomo_tempus/theme_handler.dart';
import 'package:pomo_tempus/ui/home/view_models/home_view_model.dart';
import 'package:pomo_tempus/ui/home/widgets/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(lazy: true, create: (_) => SharedPreferencesService()),
        Provider(
          lazy: true,
          create:
              (context) =>
                  SettingsRepository(sharedPreferencesService: context.read()),
        ),
        ChangeNotifierProvider(
          create:
              (context) => HomeViewModel(settingsRepository: context.read()),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeHandler = ThemeHandler.instance;
    return ValueListenableBuilder(
      valueListenable: themeHandler.themeNotifier,
      builder: (context, value, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: value, useMaterial3: true),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return HomePage(viewModel: context.read());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
