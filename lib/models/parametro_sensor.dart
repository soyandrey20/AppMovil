import 'dart:convert';

List<ParametroSensor> parametroSensorFromJson(String str) =>
    List<ParametroSensor>.from(
        json.decode(str).map((x) => ParametroSensor.fromJson(x)));

String parametroSensorToJson(List<ParametroSensor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParametroSensor {
  int idparaSensor;
  int idParametro;
  int idSensor;
  bool estado;
  ParametroSensor(
      {required this.idparaSensor,
      required this.idParametro,
      required this.idSensor,
      required this.estado});

  factory ParametroSensor.fromJson(Map<String, dynamic> json) =>
      ParametroSensor(
          idparaSensor: json["Id"],
          idParametro: json["id_parametro"],
          idSensor: json["id_sensor"],
          estado: json["estado"]);

  Map<String, dynamic> toJson() => {
        "Id": idparaSensor,
        "id_parametro": idParametro,
        "id_sensor": idSensor,
        "estado": estado
      };
}
