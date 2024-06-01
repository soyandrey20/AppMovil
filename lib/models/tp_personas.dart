import 'dart:convert';

List<TpPersona> TpPersonaFromJson(String str) =>
    List<TpPersona>.from(json.decode(str).map((x) => TpPersona.fromJson(x)));

String TpPersonaToJson(List<TpPersona> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TpPersona {
  int id;
  String descripcion;
  bool estado;

  TpPersona({
    required this.id,
    required this.descripcion,
    required this.estado,
  });

  factory TpPersona.fromJson(Map<String, dynamic> json) => TpPersona(
        id: json["id"],
        descripcion: json["descripcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
      };
}
