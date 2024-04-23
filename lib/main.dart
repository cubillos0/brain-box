import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
