import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Inicia a contagem regressiva para a navegação para outra tela
    _navigateToNextScreen();
  }

  // Função para navegar para outra tela após 3 segundos
  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Substitua LoginScreen() pela tela para a qual deseja navegar
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 71, 161, 1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/logo.png',
                width: 200,
                height: 200,
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
              CircularProgressIndicator(color: Colors.white,), // Indicador de carregamento
            ],
          ),
        ),
      ),
    );
  }
}
