import 'package:chat_app/pages/usuarios_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return const Center(child: Text('Cargando...'));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      // Conectar al Socket server
      //
      //Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsuariosPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
