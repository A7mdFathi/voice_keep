import 'package:flutter/material.dart';
import 'package:flutter_procrew/screens/home_screen.dart';
import 'package:flutter_procrew/screens/login/login_page.dart';
import 'package:flutter_procrew/screens/sign_up/sign_up_page.dart';
import 'package:flutter_procrew/screens/splash_screen.dart';

import 'app_routes_name.dart';

class AppRoutes {
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutesName.LOGIN_SCREEN:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case AppRoutesName.SIGNUP_SCREEN:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case AppRoutesName.HOME_SCREEN:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutesName.SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error Route'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
