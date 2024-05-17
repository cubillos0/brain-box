import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatelessWidget {
  Future<void> _login(BuildContext context) async {
    // Dados do login
    String email = emailController.text;
    String senha = senhaController.text;

    try {
      print("Enviando requisição para a API...");
      var response = await http.post(
        Uri.parse(
            'http://localhost/brain-box/api/login.php'), 
        body: {
          'email': email,
          'senha': senha,
        },
      );
      print("Resposta recebida: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'success') {
          Navigator.of(context).pushNamed(Routes.caixinhahome);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseBody['message']),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao fazer login: ${response.body}"),
          ),
        );
      }
    } catch (e) {
      print("Erro ao fazer login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao fazer login: $e"),
        ),
      );
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

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
              SizedBox(height: 20),

              // Campo de Login
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'nome@email.com',
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(13, 71, 161, 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // Restante do código...
                  ),
                ),
              ),

              // Campo de Senha
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(13, 71, 161, 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

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
                  // Verifica se o e-mail e a senha estão preenchidos antes de fazer o login
                  if (emailController.text.isNotEmpty &&
                      senhaController.text.isNotEmpty) {
                    _login(
                        context); // Chama a função de login apenas se os campos estiverem preenchidos
                  } else {
                    // Se os campos estiverem vazios, exibe uma mensagem ao usuário
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Preencha o e-mail e a senha."),
                      ),
                    );
                  }
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
            ],
          ),
        ),
      ),
    );
  }
}
