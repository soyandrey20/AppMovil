// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  int id;
  String email;
  String password;
  String permisos;

  Usuario({
    required this.id,
    required this.email,
    required this.password,
    required this.permisos,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        email: json["Email"],
        password: json["Password"],
        permisos: json["Permisos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Email": email,
        "Password": password,
        "Permisos": permisos,
      };
}
