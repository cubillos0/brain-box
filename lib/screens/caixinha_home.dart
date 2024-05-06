import 'package:brainbox/screens/createbox.dart';
import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/screens/myprofile.dart';
import 'package:brainbox/screens/my_box.dart';

class MyDrawer extends StatelessWidget {
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
            title: Text('Página Inicial'),
            leading: Icon(Icons.home), // Adiciona o ícone de casa
            onTap: () {
              // Implemente a ação desejada para 'Página Inicial'
            },
          ),
          ListTile(
            title: Text('Minhas caixinhas'),
            leading: Icon(Icons.archive), // Ícone de caixa aberta
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CaixinhaHome())); // Implemente a ação desejada para 'Minhas caixinhas'
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
        ],
      ),
    );
  }
}

class CaixinhaHome extends StatefulWidget {
  const CaixinhaHome({Key? key}) : super(key: key);

  @override
  CaixinhaHomeState createState() => CaixinhaHomeState();
}

class CaixinhaHomeState extends State<CaixinhaHome> {
  List<String> boxNames = []; // Lista para armazenar os nomes das caixinhas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Minhas caixinhas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D47A1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: MyDrawer(), // Adiciona o Drawer
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount:
            boxNames.length, // Use o tamanho da lista de nomes das caixinhas
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              String boxName = boxNames[index]; // Obtém o nome da caixinha
              Navigator.pushNamed(context, Routes.mybox, arguments: boxName);
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
                  SizedBox(height: 10),
                  Text(
                    boxNames[index], // Exibe o nome da caixinha
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
