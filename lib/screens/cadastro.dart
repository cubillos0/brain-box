import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:brainbox/utils/routes.dart';

class Cadastro extends StatelessWidget {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confsenhaController = TextEditingController();

  Future<void> _cadastrar(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://localhost/brain-box/api/register.php'), 
        body: {
          'nome': nomeController.text,
          'email': emailController.text,
          'senha': senhaController.text,
        },
      );

      if (response.statusCode == 200) {
        // Se o cadastro for bem-sucedido, mostre uma mensagem de sucesso ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Cadastrado com sucesso!"),
          ),
        );

        // Redirecione para a página de login após um pequeno atraso
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushNamed(Routes.login);
        });
      } else {
        // Se ocorrer um erro, mostre uma mensagem de erro ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao cadastrar: ${response.body}"),
          ),
        );
      }
    } catch (e) {
      // Se ocorrer um erro na requisição, mostre uma mensagem de erro ao usuário
      if (e is http.ClientException) {
        // Se a exceção for do tipo ClientException (erro de cliente), informe ao usuário sobre o problema de conexão
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Erro de conexão: Verifique sua conexão com a internet."),
          ),
        );
      } else {
        // Se a exceção não for do tipo ClientException, trate-a como antes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao cadastrar: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logoazul.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),

                // Campo de Nome
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    child: TextField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        hintText: 'Digite seu nome',
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(13, 71, 161, 1)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),

                // Campo de E-mail
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    child: TextField(
                      controller: emailController,
                      style:
                          TextStyle(fontSize: 18), // Tamanho da fonte aumentado
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(13, 71, 161, 1)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),

                // Campo de Senha
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    child: TextField(
                      controller: senhaController,
                      obscureText: true, // Senha oculta
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(13, 71, 161, 1)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),

                // Campo de Confirmar Senha
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    child: TextField(
                      controller: confsenhaController,
                      obscureText: true, // Senha oculta
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(13, 71, 161, 1)),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Botão de Cadastro
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(250, 60),
                  ),
                  onPressed: () {
                    _cadastrar(
                        context); // Aqui está a chamada para o método _cadastrar
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                // Espaçamento entre o botão de login e o texto "Inscrever-se"
                SizedBox(height: 20),

                // Texto "Inscrever-se" com GestureDetector
              ],
            ),
          ),
        ),
      ),
    );
  }
}
