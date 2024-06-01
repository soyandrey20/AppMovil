import 'dart:convert';

List<Usuarios> usuarioFromJson(String str) =>
    List<Usuarios>.from(json.decode(str).map((x) => Usuarios.fromJson(x)));

String usuarioToJson(List<Usuarios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuarios {
  String cedula;
  String name_1;
  String name_2;
  String lastName_1;
  String lastName_2;
  String email;
  String password;
  String permisos;
  bool estado;

  Usuarios({
    required this.cedula,
    required this.name_1,
    required this.name_2,
    required this.lastName_1,
    required this.lastName_2,
    required this.email,
    required this.password,
    required this.permisos,
    required this.estado,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        cedula: json["Cedula"],
        name_1: json["Name_1"],
        name_2: json["Name_2"],
        lastName_1: json["LastName_1"],
        lastName_2: json["LastName_2"],
        email: json["Email"],
        password: json["Password"],
        permisos: json["Permisos"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "Cedula": cedula,
        "Name_1": name_1,
        "Name_2": name_2,
        "LastName_1": lastName_1,
        "LastName_2": lastName_2,
        "Email": email,
        "Password": password,
        "Permisos": permisos,
        "Estado": estado,
      };
}
