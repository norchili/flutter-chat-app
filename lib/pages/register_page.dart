import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/button_blue.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                Logo(title: 'Registro'),
                _Form(),
                Labels(
                  route: 'login',
                  accountText: '¿Ya tienes una cuenta?',
                  sesionText: 'Inicia Sesión',
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
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.person_outline,
              placeholder: 'Nombre',
              textEditingController: nameController,
              keyboardInput: TextInputType.name),
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
                    var result = await authService.register(
                        nameController.text.trim(),
                        emailTextEditingController.text.trim(),
                        passwordTextEditingController.text.trim());

                    if (result == true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //mostrar dialogo

                      showAlert(context, 'Registro incorrecto', result);
                    }
                  },
            textBtn: 'Crear cuenta',
          )
        ],
      ),
    );
  }
}
