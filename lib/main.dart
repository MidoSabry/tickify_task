import 'package:flutter/material.dart';
import 'package:tickify_task/core/navigation/app_router.dart';
import 'package:tickify_task/core/theme/app_theme_controller.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const TickifyApp());
}

class TickifyApp extends StatelessWidget {
  const TickifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeController.themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp.router(
          title: 'Tickify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}