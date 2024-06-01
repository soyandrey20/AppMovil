import 'dart:convert';

List<Finca> fincaFromJson(String str) =>
    List<Finca>.from(json.decode(str).map((x) => Finca.fromJson(x)));

String personaToJson(List<Finca> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Finca {
  int id;
  String idPersona;
  String nombreFinca;
  int idVereda;

  bool estado;

  Finca({
    required this.id,
    required this.idPersona,
    required this.nombreFinca,
    required this.idVereda,
    required this.estado,
  });

  factory Finca.fromJson(Map<String, dynamic> json) => Finca(
        id: json["id"],
        idPersona: json["id_persona"],
        nombreFinca: json["nombre_finca"],
        idVereda: json["id_vereda"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_persona": idPersona,
        "nombre_finca": nombreFinca,
        "id_vereda": idVereda,
        "estado": estado,
      };
}
