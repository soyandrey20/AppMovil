// To parse this JSON data, do
//
//     final registro = registroFromJson(jsonString);

import 'dart:convert';

Registro registroFromJson(String str) => Registro.fromJson(json.decode(str));

String registroToJson(Registro data) => json.encode(data.toJson());

class Registro {
  String name1;
  String lastName1;
  String lastName2;
  String email;
  String password;
  String permisos;

  Registro({
    required this.name1,
    required this.lastName1,
    required this.lastName2,
    required this.email,
    required this.password,
    required this.permisos,
  });

  factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        name1: json["name_1"],
        lastName1: json["LastName_1"],
        lastName2: json["LastName_2"],
        email: json["email"],
        password: json["password"],
        permisos: json["Permisos"],
      );

  Map<String, dynamic> toJson() => {
        "name_1": name1,
        "LastName_1": lastName1,
        "LastName_2": lastName2,
        "email": email,
        "password": password,
        "Permisos": permisos,
      };
}
