import 'package:flutter/material.dart';

class CaixinhaHome extends StatefulWidget {
  const CaixinhaHome({Key? key}) : super(key: key);

  @override
  _CaixinhaHomeState createState() => _CaixinhaHomeState();
}

class _CaixinhaHomeState extends State<CaixinhaHome> {
  void _showMenu() {
    // Implemente o que acontecerá quando o menu for mostrado
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildGridItems() {
      List<Widget> items = [];
      for (int i = 0; i < 6; i++) {
        items.add(
          GestureDetector(
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
                    'Título da Caixa $i',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return items;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D47A1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
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
              title: Text('Minhas caixinhas'),
              leading: Icon(Icons.archive),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaixinhaHome(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Meu perfil'),
              leading: Icon(Icons.person),
              onTap: () {
                // Navegue para a tela de perfil
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: buildGridItems(),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          // Implemente a ação desejada para o botão de adicionar
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
