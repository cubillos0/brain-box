import 'package:brainbox/utils/routes.dart';
import 'package:flutter/material.dart';

class CreateBox extends StatefulWidget {
  const CreateBox({Key? key}) : super(key: key);

  @override
  _CreateBoxState createState() => _CreateBoxState();
}

class _CreateBoxState extends State<CreateBox> {
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
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Crie sua caixinha',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(13, 71, 161, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              minimumSize: Size(100, 48),
            ),
            onPressed: () {
              String boxName = _controller.text;
              Navigator.of(context)
                  .pushNamed(Routes.caixinhahome, arguments: boxName);
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
