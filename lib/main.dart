import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomo_tempus/theme_handler.dart';
import 'package:pomo_tempus/ui/home/view_models/home_view_model.dart';
import 'package:pomo_tempus/ui/home/widgets/home_page.dart';
import 'package:provider/provider.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeViewModel())],
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
          theme: ThemeData(colorScheme: value, useMaterial3: true),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return HomePage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final themeHandler = ThemeHandler.instance;
  // LocalNotification notification = LocalNotification(
  //   title: "local_notifier_example",
  //   body: "hello flutter!",
  // );
  Duration focusTime = Duration(minutes: 25);
  Duration restTime = Duration(minutes: 5);
  Duration oneMinute = Duration(seconds: 59);

  final winNotifyPlugin = WindowsNotification(applicationId: 'pomo_tempus');
  NotificationMessage message = NotificationMessage.fromPluginTemplate(
    "rest",
    "",
    "Focus",
  );

  void decrementTimer() async {
    while (focusTime.inMinutes > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        if (oneMinute.inSeconds == 0) {
          focusTime -= Duration(minutes: 1);
          oneMinute = Duration(seconds: 59);
          return;
        }
        oneMinute -= Duration(seconds: 1);
      });
    }
  }

  @override
  void initState() {
    decrementTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // notification.onShow = () {
    //   print('onShow ${notification.identifier}');
    // };
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter")),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${focusTime.inMinutes} : ${oneMinute.inSeconds < 10 ? '0' : ''}${oneMinute.inSeconds}',
                style: TextStyle(fontSize: 30),
              ),
              CupertinoButton(
                color: Colors.blue,
                child: const Text("dark blue"),
                onPressed: () async {
                  // notification.show();
                  await winNotifyPlugin.showNotificationPluginTemplate(message);
                  themeHandler.updateTheme(
                    ColorScheme.fromSeed(seedColor: Colors.blue),
                  );
                },
              ),
              const SizedBox(height: 15),
              CupertinoButton(
                color: Colors.amber,
                child: const Text("dark amber"),
                onPressed: () {
                  themeHandler.updateTheme(
                    ColorScheme.fromSeed(seedColor: Colors.amber),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
