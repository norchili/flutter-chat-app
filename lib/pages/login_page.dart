import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/button_blue.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(
                  title: 'Messenger',
                ),
                _Form(),
                Labels(
                  route: 'register',
                  accountText: '¿No tienes cuenta?',
                  sesionText: '¡Crea una ahora!',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo Electrónico',
            textEditingController: emailTextEditingController,
            keyboardInput: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            textEditingController: passwordTextEditingController,
            isPasdword: true,
          ),
          //TODO: Crear botton
          ButtonBlue(
            onPresed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOK = await authService.login(
                        emailTextEditingController.text.trim(),
                        passwordTextEditingController.text.trim());

                    if (loginOK) {
                      //Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                      //empezar la conexion de SocketServer
                    } else {
                      // mostrar alerta de error o que algo
                      showAlert(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
            textBtn: 'Ingresar',
          )
        ],
      ),
    );
  }
}
