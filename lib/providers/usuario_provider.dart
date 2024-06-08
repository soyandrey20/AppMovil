import 'package:empezar/importaciones/imports.dart';
import 'package:empezar/models/finca.dart';
import 'package:empezar/models/persona.dart';
import 'package:empezar/models/personas.dart';
import 'package:empezar/models/tp_personas.dart';
import 'package:empezar/models/users.dart';

import 'package:http/http.dart' as http;

const urlapi = url;
const urlArduino = url1;

class UsuarioProvider with ChangeNotifier {
  List<TipoParametro> tipoParametro = [];

  List<TipoParametro> tipoSensor = [];

  List<ParametroSensor> paraSensor = [];

  List<Persona> persona = [];

  List<TpPersona> tpPersona = [];

  List<Users> usuarios = [];

  List<Finca> fincas = [];
  var idd = '';

  Personas usuario = Personas(
    cedula: '',
    idTpersona: 0,
    nombre_1: '',
    nombre_2: '',
    lastName_1: '',
    lastName_2: '',
    email: '',
    estado: true,
  );

  UsuarioProvider() {
    getTpPersonas();
    getPersonas();
    getUsuarios();
    getTipeParameters();
    getParaSensors();
    getTipeSensors();
    getFincas();
  }

  Future<void> getFincas() async {
    final ulr1 = Uri.http(urlapi, '/fincas');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = fincaFromJson(resp.body);
    if (resp.statusCode == 200) {
      fincas.clear();
      fincas = res;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getUsuarios() async {
    final ulr1 = Uri.http(urlapi, '/usuarios');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = UsersFromJson(resp.body);
    if (resp.statusCode == 200) {
      usuarios.clear();
      usuarios = res;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getTpPersonas() async {
    final ulr1 = Uri.http(urlapi, '/Tipo_persona');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = TpPersonaFromJson(resp.body);
    if (resp.statusCode == 200) {
      tpPersona.clear();
      tpPersona = res;
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getPersona(id) async {
    idd = id.toString();
    final ulr1 = Uri.http(urlapi, '/persona/$id');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      print(resp.body);
      final response = personasFromJson(resp.body);

      usuario.cedula = response.cedula;
      usuario.nombre_1 = response.nombre_1;
      usuario.nombre_2 = response.nombre_2;
      usuario.lastName_1 = response.lastName_1;
      usuario.lastName_2 = response.lastName_2;
      usuario.email = response.email;

      usuario.estado = response.estado;

      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> updatePersona(
      String cedula,
      String nombre1,
      String nombre2,
      String apellido1,
      String apellido2,
      String email,
      String password,
      String permisos,
      bool estado) async {
    final url1 = Uri.http(urlapi, '/Usuarios/$cedula');
    final resp = await http.put(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'cedula': cedula,
          'name_1': nombre1,
          'name_2': nombre2,
          'LastName_1': apellido1,
          'LastName_2': apellido2,
          'email': email,
          'password': password,
          'Permisos': permisos,
          'Estado': estado
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }

  Future<void> restorePasword(id) async {
    final ulr1 = Uri.http(urlapi, '/enviarcorreo');
    final resp = await http.post(ulr1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id': id,
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getTipeParameters() async {
    final ulr1 = Uri.http(urlapi, '/Tipo_parametro');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = tipoParametroFromJson(resp.body);
    if (resp.statusCode == 200) {
      tipoParametro.clear();
      tipoParametro = res;
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getTipeSensors() async {
    final ulr1 = Uri.http(urlapi, '/Tipo_sensor');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = tipoParametroFromJson(resp.body);
    if (resp.statusCode == 200) {
      tipoSensor.clear();
      tipoSensor = res;
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getParaSensors() async {
    final ulr1 = Uri.http(urlapi, '/parametro_sensor');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = parametroSensorFromJson(resp.body);
    if (resp.statusCode == 200) {
      paraSensor.clear();
      paraSensor = res;
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> addPersona(
      String cedula,
      int idTpPersona,
      String nombre1,
      String nombre2,
      String apellido1,
      String apellido2,
      String email,
      String password,
      String permisos,
      bool estado) async {
    final url1 = Uri.http(urlapi, '/Usuarios');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'Cedula': cedula,
          'id_tipo_persona': idTpPersona,
          'Nombre_1': nombre1,
          'Nombre_2': nombre2,
          'LastName_1': apellido1,
          'LastName_2': apellido2,
          'Email': email,
          'password': password,
          'Permisos': permisos,
          'Estado': estado
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }

  Future<void> getPersonas() async {
    final ulr1 = Uri.http(urlapi, '/persona');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = personaFromJson(resp.body);
    if (resp.statusCode == 200) {
      persona.clear();
      persona = res;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> llamarArduino(
    String fecha,
    String finca,
    String informacion,
    String correo,
    String nombre,
    String apellido,
  ) async {
    final ulr1 = Uri.http(urlArduino, '/read-sensor');
    http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    enviarAnalisis(fecha, finca, informacion, correo, nombre, apellido);
  }

  Future<void> enviarAnalisis(
    String fecha,
    String finca,
    String informacion,
    String correo,
    String nombre,
    String apellido,
  ) async {
    final url1 = Uri.http(urlapi, '/AgregarValor');
    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'fecha': fecha,
          'finca': finca,
          'informacion': informacion,
          'correo': correo,
          'nombre': nombre,
          'apellido': apellido,
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }
}
