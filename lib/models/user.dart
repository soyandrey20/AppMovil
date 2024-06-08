import 'dart:convert';

User UserFromJson(String str) => User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());

class User {
  String cedula;
  String password;
  String permisos;
  bool estado;

  User({
    required this.cedula,
    required this.password,
    required this.permisos,
    required this.estado,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
