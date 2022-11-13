import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

import 'series.dart';

final String urlBase = 'http://192.168.1.7/api/api/';
Future<List<String>> placas() async {
  String url = urlBase + 'transportistas';
  List<String> errores = new List();

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
        print('Placas encontradas: $jsonResponse');
        return transportistasFromJson(response.body);
      case 500:
        return null;
      default:
        //Se usa la salida -2 para determinar que el error no es
        //relacionado a con datos incorrectos de sesion, si no otro error
        errores.add('-2');
        errores.add(
            'El servidor respondio con: ' + response.statusCode.toString());
        return errores;
    }
  } finally {}
}

Future<String> createPostList(List<Series> post) async {
  try {
    String url = urlBase + 'series';
    String output = '';
    for (Series s in post) {
      print(seriesToJson(s));
      final response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: seriesToJson(s));
      output = convert.jsonDecode(response.body);
    }
    return output;
  } catch (Exception) {
    return null;
  }
}

Future<List<String>> seriesSacService() async {
  String url = urlBase + 'sac';
  List<String> errores = new List();

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
        return seriesSacFromJson(response.body);
      case 500:
        return null;
      default:
        errores.add('-2');
        errores.add(
            'El servidor respondio con: ' + response.statusCode.toString());
        return errores;
    }
  } finally {}
}
