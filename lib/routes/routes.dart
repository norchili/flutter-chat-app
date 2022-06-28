import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => const UsuariosPage(),
  'chat': (_) => const ChatPage(),
  'register': (_) => const RegisterPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage()
};
