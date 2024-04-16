import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 230.0), // Adicione um espaço no topo
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Alinhe os filhos ao topo
            children: [
              Image.asset(
                'assets/image/logo.png',
                width: 250,
                height: 250,
              ),
              Text(
                'BrainBox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.login);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromRGBO(13, 71, 161, 1),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 8,
                  minimumSize: Size(250, 60),
                ),
                child: Text('Começar', style: TextStyle(fontSize: 19)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
