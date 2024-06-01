import 'dart:convert';

Personas personasFromJson(String str) => Personas.fromJson(json.decode(str));

String personasToJson(Personas data) => json.encode(data.toJson());

class Personas {
  String cedula;
  int idTpersona;
  String nombre_1;
  String nombre_2;
  String lastName_1;
  String lastName_2;
  String email;
  bool estado;

  Personas({
    required this.cedula,
    required this.idTpersona,
    required this.nombre_1,
    required this.nombre_2,
    required this.lastName_1,
    required this.lastName_2,
    required this.email,
    required this.estado,
  });

  factory Personas.fromJson(Map<String, dynamic> json) => Personas(
        cedula: json["cedula"],
        idTpersona: json["id_tipo_persona"],
        nombre_1: json["Nombre_1"],
        nombre_2: json["Nombre_2"],
        lastName_1: json["LastName_1"],
        lastName_2: json["LastName_2"],
        email: json["email"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "id_tipo_persona": idTpersona,
        "Nombre_1": nombre_1,
        "Nombre_2": nombre_2,
        "LastName_1": lastName_1,
        "LastName_2": lastName_2,
        "email": email,
        "estado": estado,
      };
}
