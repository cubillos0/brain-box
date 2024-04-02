import 'package:flutter/material.dart';

class caixinha_home extends StatefulWidget {
  const caixinha_home({Key? key}) : super(key: key);

  @override
  State<caixinha_home> createState() => _caixinha_homeState();
}

class _caixinha_homeState extends State<caixinha_home> {
  @override
  Widget build(BuildContext context) {
    final String? boxName =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('$boxName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Digite o título da sua tela',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
