import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sisyphus/core/core.dart';
import 'package:sisyphus/features/home/presentation/ui/screens/home_screen.dart';
import 'package:sisyphus/shared/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() => Timer(const Duration(seconds: 2), changeScreen);

  Future<void> changeScreen() async {
    Navigator.of(context).popAndPushNamed(HomeScreen.routeName);

    //Show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
        child: Center(
          child: SvgPicture.asset(context.isDarkMode() ? ImageAssets.logoLight : ImageAssets.logoDark),
        ));
  }
}
