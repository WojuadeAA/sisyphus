import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/presentation/ui/screens/splash_screen.dart';
import 'package:sisyphus/features/home/presentation/viewmodel/notifiers/theme_notifier.dart';
import 'package:sisyphus/shared/utils/utils.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Sisyphus',
      themeMode: ref.watch(themeNotifierProvider),
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
