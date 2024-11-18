import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon_clone/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    //We can do an Error Page at the end for default
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page does not exist"),
                ),
              ));
  }
}
