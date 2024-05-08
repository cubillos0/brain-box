import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  Future<void> _login(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://localhost/api/brainbox.php'), // Substitua pela URL da sua API de login
        body: {
          'email': emailController.text,
          'senha': senhaController.text,
        },
      );

      if (response.statusCode == 200) {
        // Se o login for bem-sucedido (código 200), navegue para a próxima tela
        Navigator.of(context).pushNamed(Routes.caixinhahome);
      } else {
        // Se ocorrer um erro, mostre uma mensagem de erro ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao fazer login: ${response.body}"),
          ),
        );
      }
    } catch (e) {
      // Se ocorrer um erro na requisição, mostre uma mensagem de erro ao usuário
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
                  _login(context);
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
