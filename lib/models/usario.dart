import 'dart:convert';

Usuario usuariooFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuariooToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String cedula;
  String name_1;
  String lastName_1;
  String lastName_2;
  String email;
  String password;

  Usuario({
    required this.cedula,
    required this.name_1,
    required this.lastName_1,
    required this.lastName_2,
    required this.email,
    required this.password,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        cedula: json["Cedula"],
        name_1: json["Name_1"],
        lastName_1: json["LastName_1"],
        lastName_2: json["LastName_2"],
        email: json["Email"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Cedula": cedula,
        "Name_1": name_1,
        "LastName_1": lastName_1,
        "LastName_2": lastName_2,
        "Email": email,
        "Password": password,
      };
}
