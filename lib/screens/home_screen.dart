import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:brainbox/screens/login.dart';
import 'package:brainbox/screens/caixinha_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brainbox/screens/auth_manager.dart'; // Importe a classe AuthManager

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Inicia a verificação do token
    _navigateToNextScreen();
  }

  // Função para navegar para outra tela após verificar o token
  void _navigateToNextScreen() async {
    // Aguarda 3 segundos antes de verificar o token
    await Future.delayed(Duration(seconds: 3));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      // Se o token estiver presente, verifica a validade
      bool isValid = await AuthManager.isTokenValid(token);
      if (isValid) {
        // Se o token for válido, navegue para a tela principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => caixinha_home()), // Substitua HomeScreen pela tela principal do seu app
        );
      } else {
        // Se o token não for válido, navegue para a tela de login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } else {
      // Se não houver token, navegue para a tela de login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D47A1),
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
              CircularProgressIndicator(
                color: Colors.white,
              ), // Indicador de carregamento
            ],
          ),
        ),
      ),
    );
  }
}
