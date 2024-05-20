import 'package:flutter/material.dart';
import 'auth_manager.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Adicione a foto do usuário aqui
              CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/user_profile_image.jpg'),
              ),
              SizedBox(height: 24.0),
              // Adicione os dados do usuário

              Text(
                'Username',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'E-mail: ',
                style: TextStyle(fontSize: 16.0),
              ),
              // Adicione outros dados do usuário conforme necessário

              // Adicione um botão para editar o perfil, se desejar
              GestureDetector(
                onTap: () {
                  // Implemente a ação desejada para editar o perfil
                },
                child: Text(
                  'Editar Perfil',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(
                        13, 71, 161, 1), // Cor do texto ao ser pressionado
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
