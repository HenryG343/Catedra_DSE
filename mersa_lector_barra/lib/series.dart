import 'dart:convert';
String seriesToJson(Series data) => json.encode(data.toJson());

class Series{
  Series({
    this.id_usuario,
    this.serie,
    this.placa,
  });

  //Atributos
  int id_usuario;
  String serie;
  String placa;

  //Para convertir a Json
  Map<String, dynamic> toJson() => {
    "id_usuario": id_usuario,
    "serie": serie,
    "placa": placa,
  };

  Series.fromJson(Map<String, dynamic> json)
      : id_usuario = json['id_usuario'],
        serie = json['serie'],
        placa = json['placa'];

}

// To parse this JSON data, do
//
//     final transportistas = transportistasFromJson(jsonString);

List<String> transportistasFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String transportistasToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

//Para obtner las series enviadas por el Web Service, provenientes del SAC de la base de datos, para validar las series escaneadas
List<String> seriesSacFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String seriesSacToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));