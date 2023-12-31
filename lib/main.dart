import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_theme/system_theme.dart';
import 'package:tales/Pages/page_starting.dart';
import 'package:window_manager/window_manager.dart';

import 'app_providers.dart' as app_providers;
import 'app_themes.dart' as app_themes;

Future<void> main() async {
  ///Initialize Flutter & Window Manager
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  ///Initialize System Accent Colour
  SystemTheme.fallbackColor = const Color(0xFF0D87F7);
  await SystemTheme.accentColor.load();

  ///Set Min Window Size
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(600, 400),
    center: true,
    title: "Tales",
    backgroundColor: Color(0xFF0C0C0C),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  ///Initialize SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        app_providers.sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: TalesApp(
        windowManager: windowManager,
      ),
    ),
  );
}

class TalesApp extends ConsumerWidget {
  const TalesApp({this.windowManager, super.key});

  final WindowManager? windowManager;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theme.firstBackground,
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: PageStarting()
        ),
      ),
    );
  }
}
