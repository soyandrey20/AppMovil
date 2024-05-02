import 'dart:convert';

List<TipoParametro> tipoParametroFromJson(String str) =>
    List<TipoParametro>.from(
        json.decode(str).map((x) => TipoParametro.fromJson(x)));

String tipoParametroToJson(List<TipoParametro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoParametro {
  int id;
  String descripcion;

  TipoParametro({
    required this.id,
    required this.descripcion,
  });

  factory TipoParametro.fromJson(Map<String, dynamic> json) => TipoParametro(
        id: json["Id"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
      };
}
