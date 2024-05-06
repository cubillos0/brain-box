import 'package:flutter/material.dart';
import 'package:brainbox/utils/routes.dart';

class MyBox extends StatelessWidget {
  final String? boxName;

  MyBox({required this.boxName, TextEditingController? controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boxName ?? 'Sua caixinha'),
      ),
      body: Center(
        child: Text(
          'O nome da sua caixinha é: ${boxName ?? "Nome da Caixinha"}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
