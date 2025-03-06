import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisyphus/features/home/presentation/ui/screens/home_screen.dart';
import 'package:sisyphus/features/home/presentation/ui/screens/splash_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (routes.keys.contains(settings.name)) {
      return Platform.isIOS
          ? CupertinoPageRoute(builder: routes[settings.name]!)
          : MaterialPageRoute(builder: routes[settings.name]!);
    } else {
      return CupertinoPageRoute(builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
