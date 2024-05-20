import 'package:brainbox/screens/myprofile.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_manager.dart'; // Importe a classe AuthManager
import 'dart:convert';

class caixinha_home extends StatefulWidget {
  const caixinha_home({Key? key}) : super(key: key);

  @override
  CaixinhaHomeState createState() => CaixinhaHomeState();
}

class CaixinhaHomeState extends State<caixinha_home> {
  void _showMenu() {
    // Implemente o que acontecerá quando o menu for mostrado
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    prefs.remove('token');
    Navigator.of(context).pushNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D47A1),
        iconTheme: IconThemeData(
            color: Colors
                .white), // Define a cor do ícone do menu hamburguer como branco
      ),
      drawer: Drawer(
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
                    builder: (context) => Profile(),
                  ),
                ); // Implemente a ação desejada para 'Meu perfil'
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
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 6, // número de ícones de caixa que você deseja exibir
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Aqui você pode adicionar a navegação para a página caixinha_home com o título adequado
              // Navigator.pushNamed(context, '/caixinha_home', arguments: 'Título da Caixa $index');
            },
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/box_icon.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Título da Caixa $index',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.createbox);
        },
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
      ),
    );
  }
}
