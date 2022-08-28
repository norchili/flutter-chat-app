import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.0.150:3001/api'
      : 'http://localhost:3001/api';

  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.0.2:3001' : 'http://localhost:3001';
}
