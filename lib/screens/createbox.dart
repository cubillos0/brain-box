import 'package:brainbox/screens/my_box.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              // Enviar o nome da caixinha para a API
              final response = await http.post(
                Uri.parse('http://localhost/brain-box/api/criar_caixinha.php'),
                body: {'nome_caixinha': _controller.text},
              );

              // Verificar a resposta da API
              if (response.statusCode == 200) {
                // Se o cadastro for bem-sucedido, mostre uma mensagem de sucesso ao usuário
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Caixinha criada com sucesso!"),
                  ),
                );

                // Redirecione para a página de login após um pequeno atraso
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pushNamed(Routes.mybox);
                });
              } else {
                // Erro ao criar caixinha
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao criar caixinha')),
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
