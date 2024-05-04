import 'package:empezar/importaciones/imports.dart';

import 'package:http/http.dart' as http;

const urlapi = url;

class UsuarioProvider with ChangeNotifier {
  List<Usuarios> usuarios = [];

  List<TipoParametro> tipoParametro = [];

  List<TipoParametro> tipoSensor = [];

  List<ParametroSensor> paraSensor = [];

  var idd = '';

  Usuario usuario = Usuario(
    cedula: '',
    name_1: '',
    name_2: '',
    lastName_1: '',
    lastName_2: '',
    email: '',
    password: '',
    permisos: '',
    estado: true,
  );

  UsuarioProvider() {
    getUsers();
    getTipeParameters();
    getTipeSensors();
    getParaSensors();
  }

  Future<void> getUsers() async {
    final ulr1 = Uri.http(urlapi, '/Usuarios');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final res = usuarioFromJson(resp.body);
    if (resp.statusCode == 200) {
      usuarios = res;
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> getUser(id) async {
    idd = id.toString();
    final ulr1 = Uri.http(urlapi, '/Usuarios/$id');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (resp.statusCode == 200) {
      final response = usuariooFromJson(resp.body);
      usuario.cedula = response.cedula;
      usuario.name_1 = response.name_1;
      usuario.name_2 = response.name_2;
      usuario.lastName_1 = response.lastName_1;
      usuario.lastName_2 = response.lastName_2;
      usuario.email = response.email;
      usuario.password = response.password;
      usuario.permisos = response.permisos;
      usuario.estado = response.estado;

      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $ulr1');
      }
    }
  }

  Future<void> addUser(
      String cedula,
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

  Future<void> updateUser(
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
      usuarios.clear();
      getUsers();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }

  Future<void> deleteUser(String cedula, bool estado) async {
    final url1 = Uri.http(urlapi, '/DeleteUsuarios/$cedula');
    final resp = await http.put(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'cedula': cedula, 'Estado': estado}));
    if (resp.statusCode == 200) {
      notifyListeners();
      usuarios.clear();
      getUsers();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }

  Future<void> restorePasword(id) async {
    final ulr1 = Uri.http(urlapi, '/enviarcorreo/$id');
    await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }

  Future<void> addTipeParametro(String descripcion) async {
    final url1 = Uri.http(urlapi, '/Tipo_parametro');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'Descripcion': descripcion,
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

  Future<void> addTipeSensor(String descripcion) async {
    final url1 = Uri.http(urlapi, '/Tipo_sensor');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'Descripcion': descripcion,
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

  Future<void> deleteTipeSensor(String descripcion) async {
    final url1 = Uri.http(urlapi, '/Tipo_sensor/$descripcion');
    final resp = await http.delete(url1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      if (kDebugMode) {
        print('Error en la solicitud: ${resp.statusCode} ${resp.body} $url1');
      }
    }
  }

  Future<void> addSensor(String informacion, int id) async {
    final url1 = Uri.http(urlapi, '/sensor');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'informacion': informacion,
          'id_tp_sensor': id,
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

  Future<void> addParametro(String inferior, String superior, int id) async {
    final url1 = Uri.http(urlapi, '/parametro');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'inferior': inferior,
          'superior': superior,
          'id_tp_para': id,
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

  Future<void> addParaSensor(int idSensor, int idParametro) async {
    final url1 = Uri.http(urlapi, '/parametro_sensor');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id_sensor': idSensor,
          'id_parametro': idParametro,
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
}
