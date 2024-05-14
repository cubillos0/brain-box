import 'package:brainbox/screens/my_box.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Createbox extends StatefulWidget {
  const Createbox({Key? key}) : super(key: key);

  @override
  _CreateboxState createState() => _CreateboxState();
}

class _CreateboxState extends State<Createbox> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _createBox(String name) async {
    // URL da sua API para criar caixinhas
    final String apiUrl = 'http://localhost/api/brainbox.php';

    try {
      // Faz a solicitação HTTP POST para a API
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'name': name}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Verifica se a solicitação foi bem-sucedida
      if (response.statusCode == 200) {
        // Se a criação da caixinha foi bem-sucedida, exibe uma mensagem para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Caixinha criada com sucesso!'),
          ),
        );
      } else {
        // Se a solicitação falhou, exibe uma mensagem de erro para o usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao criar caixinha'),
          ),
        );
      }
    } catch (error) {
      // Em caso de erro, exibe uma mensagem de erro genérica
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            'De um nome para sua caixinha!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF0D47A1) // Título adicionado
          ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Crie sua caixinha', // Texto do campo de entrada
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              minimumSize: Size(100, 48),
            ),
            onPressed: () {
              String name = _controller.text.trim();
              if (name.isNotEmpty) {
                // Chama a função para criar a caixinha
                _createBox(name);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Por favor, insira um nome para a caixinha'),
                  ),
                );
              }
            },
            child: Text(
              'Criar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
