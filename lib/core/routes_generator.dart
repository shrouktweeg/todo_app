import 'package:flutter/material.dart';
import 'package:todo/moduls/edit%20task/edit_task.dart';
import 'package:todo/moduls/layout_view.dart';
import 'package:todo/moduls/login/login_view.dart';
import 'package:todo/moduls/registration/registration_view.dart';
import 'package:todo/moduls/splash/splash_view.dart';

import 'pages_routes_name.dart';
class RoutesGenerator {

 static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(), settings: settings,);
      case PageRouteName.registration:
        return MaterialPageRoute(
          builder: (context) => const RegistrationView(), settings: settings,);
      case PageRouteName.layout:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(), settings: settings,);
      case PageRouteName.edit:
        return MaterialPageRoute(
          builder: (context) => const EditTask(), settings: settings,);

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
    }
  }
}
