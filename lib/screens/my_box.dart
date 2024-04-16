import 'package:brainbox/screens/caixinha_home.dart';
import 'package:brainbox/screens/myprofile.dart';
import 'package:flutter/material.dart';
import 'package:brainbox/screens/createbox.dart';

class MyBox extends StatefulWidget {
  final TextEditingController? controller;

  MyBox({required this.controller});

  @override
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  List<String> annotations = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(13, 71, 161, 1),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.controller?.text ?? 'MINHA CAIXINHA',
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
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Imagem'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _addImage(); // Handle adding image
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Documento'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _addDocument(); // Handle adding document
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Links'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _addLinks(); // Handle adding links
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

  void _addImage() {
    // Handle adding image
    print('Adicionar Imagem');
  }

  void _addDocument() {
    // Handle adding document
    print('Adicionar Documento');
  }

  void _addLinks() {
    // Handle adding links
    print('Adicionar Links');
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

class Mybox extends StatelessWidget {
  const Mybox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? boxName =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sua caixinha'),
      ),
      body: Center(
        child: Text(
          'O nome da sua caixinha é: $boxName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
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
                          caixinha_home())); // Implemente a ação desejada para 'Minhas caixinhas'
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
