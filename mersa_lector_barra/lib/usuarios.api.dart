import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> login(String duiLogin, String passLogin) async {
  String url = 'http://192.168.1.7/api/api/usuarios?dui=' +
      duiLogin +
      '&pass=' +
      passLogin;

  try {
    http.Response response;
     response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 120),
      );

    switch (response.statusCode) {
      case 200:
        var jsonResponse = convert.jsonDecode(response.body);
        print('Respuesta del servidor: ' + jsonResponse);
        return jsonResponse;
      case 500:
        //Para saber si el error se produjo
        //por datos incorrectos
        //es decir sesion incorrecta
        return null;
      default:
        //Se usa la salida -2 para determinar que el error no es
        //relacionado a con datos incorrectos de sesion, si no otro error
        return '-2;El servidor respondio con: ' +
            response.statusCode.toString();
    }
  }finally {
  }
}
