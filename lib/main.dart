import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/home_screen.dart';

<<<<<<< HEAD
void main() {
  runApp(const MyApp());
=======
void main() async {
  runApp(MyApp());
>>>>>>> 8ba72141911d160350fcbf3a74d0d9f3cacce3fb
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
