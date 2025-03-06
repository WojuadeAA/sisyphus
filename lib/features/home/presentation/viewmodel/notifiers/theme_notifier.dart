import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  build() {
    return ThemeMode.system;
  }

  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: state == ThemeMode.light ? Brightness.light : Brightness.dark,
    ));
  }

  void toggleTheme() {
    state = switch (state) {
      ThemeMode.system => SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
    };

    setStatusBar();
  }
}
