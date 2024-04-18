// To parse this JSON data, do
//
//     final usuarioo = usuariooFromJson(jsonString);

import 'dart:convert';

Usuarioo usuariooFromJson(String str) => Usuarioo.fromJson(json.decode(str));

String usuariooToJson(Usuarioo data) => json.encode(data.toJson());

class Usuarioo {
  String name1;
  String lastName1;
  String lastName2;
  String email;
  String password;

  Usuarioo({
    required this.name1,
    required this.lastName1,
    required this.lastName2,
    required this.email,
    required this.password,
  });

  factory Usuarioo.fromJson(Map<String, dynamic> json) => Usuarioo(
        name1: json["name_1"],
        lastName1: json["LastName_1"],
        lastName2: json["LastName_2"],
        email: json["Email"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "name_1": name1,
        "LastName_1": lastName1,
        "LastName_2": lastName2,
        "Email": email,
        "Password": password,
      };
}
