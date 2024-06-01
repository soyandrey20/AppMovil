import 'dart:convert';

List<Users> UsersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String UsersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String cedula;
  String password;
  String permisos;
  bool estado;

  Users({
    required this.cedula,
    required this.password,
    required this.permisos,
    required this.estado,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        cedula: json["Cedula"],
        password: json["Password"],
        permisos: json["Permisos"],
        estado: json["Estado"],
      );

  Map<String, dynamic> toJson() => {
        "Cedula": cedula,
        "Password": password,
        "Permisos": permisos,
        "Estado": estado,
      };
}
