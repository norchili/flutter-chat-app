import 'package:chat_app/widgets/button_blue.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

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
            onPresed: () {
              print(emailTextEditingController.text);
              print(passwordTextEditingController.text);
            },
            textBtn: 'Ingresar',
          )
        ],
      ),
    );
  }
}
