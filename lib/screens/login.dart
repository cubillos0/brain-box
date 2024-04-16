import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/logoazul.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                  height: 20), // Espaçamento entre o logo e os campos de login

              // Campo de Login
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Color.fromRGBO(13, 71, 161, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              // Campo de Senha
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'Senha',
                      style: TextStyle(
                        color: Color.fromRGBO(13, 71, 161, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 35),

              // Botão de Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 71, 161, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: Size(220, 60),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.createbox);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              SizedBox(
                  height:
                      20), // Espaçamento entre o botão de Login e o texto "Inscrever-se"

              // Texto "Inscrever-se"
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.cadastro);
                },
                child: Text(
                  'Inscrever-se',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(13, 71, 161, 1),
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaçamento entre os botões

              // Botão de Esqueceu a Senha
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Esqueceu sua senha',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(13, 71, 161, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
