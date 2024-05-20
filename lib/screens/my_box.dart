import 'package:brainbox/screens/caixinha_home.dart';
import 'package:brainbox/screens/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brainbox/utils/routes.dart';
import 'auth_manager.dart';

class MyBox extends StatefulWidget {
  final TextEditingController? controller;

  MyBox({this.controller});

  @override
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  List<String> annotations = [];
  String? caixinhaName;

  

  @override
  void initState() {
    super.initState();
     _initialize();
  }

  Future<void> _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null || !(await AuthManager.isTokenValid(token))) {
      // Se o token não for válido ou não existir, redireciona para a tela de login
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      // Se o token for válido, continua a inicialização
      await fetchCaixinhaName(token);
      await retrieveLocalCaixinhaName();
    }
  }

  Future<void> retrieveLocalCaixinhaName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      caixinhaName = prefs.getString('nome_caixinha');
    });
  }

  Future<void> sendDataToAPI(
      String anotacao, String imagem, String documento, String links) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    if (token == null) {
      // Notificar o usuário sobre a falta de token
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: usuário não autenticado')),
      );
      return;
    }
  
    final response = await http.post(
      Uri.parse('http://localhost/brain-box/api/mybox.php'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
      body: {
        'anotacao': anotacao,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        // Faça o que for necessário após o envio bem-sucedido
      } else {
        // Lida com erros
      }
    } else {
      // Lida com erros de conexão
    }
  }

  Future<void> fetchCaixinhaName(String? token) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/brain-box/api/mybox.php'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            caixinhaName = data['caixinha']['nome'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
        } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar nome da caixinha')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(13, 71, 161, 1),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            caixinhaName ?? 'MINHA CAIXINHA',
            style: TextStyle(color: Colors.white),
          ),
        ),

        
        drawer: MyDrawer(), // Adiciona o Drawer
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            for (var annotation in annotations)
              PostItAnnotation(annotation: annotation),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  onSave: (annotation) {
                    setState(() {
                      annotations.add(annotation);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final Function(String) onSave;

  MyButton({required this.onSave});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isMenuOpen = false;
  TextEditingController _textController = TextEditingController();
  

  void _showMenu() {
    setState(() {
      _isMenuOpen = true;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Anotação'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _showPostItNote(context); // Show the post-it note
              },
            ),
            
          ],
        );
      },
    ).whenComplete(() {
      setState(() {
        _isMenuOpen = false;
      });
    });
  }

  void _showPostItNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Anotação'),
          content: TextField(
            controller: _textController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Digite sua anotação',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Handle the annotation, for example, you can access the text using _textController.text
                final annotation = _textController.text;
                widget.onSave(annotation);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showMenu,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}


class PostItAnnotation extends StatelessWidget {
  final String annotation;

  PostItAnnotation({required this.annotation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(annotation),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {

  // Método para realizar o logout
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id'); // Remove o user_id do SharedPreferences
    prefs.remove('token'); // Remove o token do SharedPreferences
    }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(13, 71, 161, 1),
            ),
            child: Image.asset(
              'assets/image/logo.png',
              width: 100,
              height: 100,
            ),
          ),
          ListTile(
            title: Text('Minhas caixinhas'),
            leading: Icon(Icons.archive), // Ícone de caixa aberta
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          caixinha_home())); // Implemente a ação desejada para 'Minhas caixinhas'
            },
          ),
          ListTile(
              title: Text('Criar Caixinha'),
              leading: Icon(Icons.add_box), // Ícone de adicionar caixinha
              onTap: () {
                Navigator.pushNamed(context, Routes.createbox); // Rota para Createbox
              },
            ),
          ListTile(
            title: Text('Meu perfil'),
            leading: Icon(Icons.person), // Ícone de perfil de usuário
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Profile())); // Implemente a ação desejada para 'Meu perfil'
            },
          ),
          ListTile(
              title: Text('Sair'),
              leading: Icon(Icons.logout), // Ícone de logout
              onTap: () {
                _logout(context); // Chama o método de logout ao pressionar "Sair"
              },
            ),
        ],
      ),
    );
  }
}
