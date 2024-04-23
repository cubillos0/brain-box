import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brainbox/utils/routes.dart';

class Login extends StatelessWidget {
  const Login({Key? key});

  Future<void> _login(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Se o login for bem-sucedido, navegue para a próxima tela
      Navigator.of(context).pushNamed(Routes.caixinhahome);
    } catch (e) {
      // Se ocorrer um erro durante o login, você pode tratar aqui
      print("Erro durante o login: $e");
      // Por exemplo, você pode exibir uma mensagem de erro para o usuário
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erro durante o login. Verifique suas credenciais."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onChanged: (value) => email = value,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(13, 71, 161, 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onChanged: (value) => password = value,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(13, 71, 161, 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 35),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 71, 161, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  minimumSize: Size(220, 60),
                ),
                onPressed: () => _login(context, email, password),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.cadastro);
                },
                child: Text(
                  'Inscrever-se',
                  style: TextStyle(
                      fontSize: 18.0, color: Color.fromRGBO(13, 71, 161, 1)),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Esqueceu sua senha',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(13, 71, 161, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
