import 'package:brainbox/screens/my_box.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'auth_manager.dart';

class Createbox extends StatefulWidget {
  const Createbox({Key? key}) : super(key: key);

  @override
  _CreateboxState createState() => _CreateboxState();
}

class _CreateboxState extends State<Createbox> {
  final TextEditingController _controller = TextEditingController();

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
            onPressed: () async {
              await _createBox();
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

  Future<void> _createBox() async {
    final prefs = await SharedPreferences.getInstance();
    final nomeCaixinha = _controller.text;

    // Verificar se o user_id está presente no SharedPreferences
    final userId = prefs.getString('user_id');
    final token = prefs.getString('token');
    print('Token recuperado: $token');

    if (userId == null || token == null) {
      // Notificar o usuário sobre o erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: usuário não autenticado')),
      );
      return;
    }

    // Verifica a validade do token antes de prosseguir
    bool isValid = await AuthManager.isTokenValid(token);
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: token inválido ou expirado')),
      );
      return;
    }

    print('Token recuperado: $token');
    try {
      final Map<String, dynamic> data = {
        'token': token,
        'nome_caixinha': nomeCaixinha,
        'user_id': userId,
      };

      final response = await http.post(
        Uri.parse('http://localhost/brain-box/api/criar_caixinha.php'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Caixinha criada com sucesso!")),
          );
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pushNamed(Routes.mybox);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao criar caixinha: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print('Erro ao criar caixinha: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar caixinha: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
