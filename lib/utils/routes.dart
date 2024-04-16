import 'dart:js';

import 'package:brainbox/screens/cadastro.dart';
import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/screens/home_screen.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/my_box.dart';
import 'package:brainbox/screens/caixinha_home.dart';
import 'package:brainbox/screens/myprofile.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homepage = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String createbox = '/criar_caixinha';
  static const String mybox = '/my_box';
  static const String caixinhahome = '/caixinha_home';
  static const String profile = '/myprofile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );

      case cadastro:
        return MaterialPageRoute(builder: (context) => Cadastro());

      case createbox:
        return MaterialPageRoute(builder: (context) => Createbox());

      case mybox:
        final TextEditingController? controller =
            settings.arguments as TextEditingController?;
        return MaterialPageRoute(
          builder: (_) => MyBox(controller: controller),
        );

      case caixinhahome:
        return MaterialPageRoute(builder: (context) => CaixinhaHome());

      case profile:
        return MaterialPageRoute(builder: (context) => Profile());

      default:
        throw FormatException('Routes not found! Check routes again');
    }
  }
}
