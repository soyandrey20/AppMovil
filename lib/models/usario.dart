import 'dart:convert';

Usuario usuariooFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuariooToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String cedula;
  String name_1;
  String name_2;
  String lastName_1;
  String lastName_2;
  String email;
  String password;
  String permisos;
  bool estado;

  Usuario({
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

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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
