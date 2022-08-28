import 'dart:convert';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../global/environment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  final _storage = const FlutterSecureStorage();

  // getters staticos
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => _autenticando;

  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    //Payload
    final data = {'email': email, 'password': password};
    final url = '${Environment.apiUrl}/login';

    final resp = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      //Todo: Guardar Token en un lugar seguro
      await _saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    autenticando = true;
    //Payload
    final data = {'nombre': name, 'email': email, 'password': password};

    final url = '${Environment.apiUrl}/login/new';

    final resp = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;

      //Todo: Guardar Token en un lugar seguro
      await _saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      return false;
    } else {
      final url = '${Environment.apiUrl}/login/renew';

      final resp = await http.get(Uri.parse(url),
          headers: {'Content-Type': 'application/json', 'x-token': token});

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.usuario;

        //Todo: Guardar Token en un lugar seguro
        await _saveToken(loginResponse.token);

        return true;
      } else {
        logOut();
        return false;
      }
    }
  }

  Future _saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    //Al salir, eliminar token y demas cosas guardadas en storage

    await _storage.delete(key: 'token');
  }
}
