import 'dart:convert';

List<TipoParametro> tipoParametroFromJson(String str) =>
    List<TipoParametro>.from(
        json.decode(str).map((x) => TipoParametro.fromJson(x)));

String tipoParametroToJson(List<TipoParametro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoParametro {
  int id;
  String descripcion;
  bool estado;

  TipoParametro({
    required this.id,
    required this.descripcion,
    required this.estado,
  });

  factory TipoParametro.fromJson(Map<String, dynamic> json) => TipoParametro(
        id: json["Id"],
        descripcion: json["Descripcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        "estado": estado,
      };
}
