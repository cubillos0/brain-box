import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.homepage,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
