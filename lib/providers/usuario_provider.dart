import 'package:empezar/importaciones/imports.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class UsuarioProvider with ChangeNotifier {
  List<Usuarios> usuarios = [];

  List<TipoParametro> tipoParametro = [];

  List<TipoParametro> tipoSensor = [];

  List<Usuario> usuarioo = [];

  var idd = '';

  Usuario usuario = Usuario(
    cedula: '',
    name_1: '',
    lastName_1: '',
    lastName_2: '',
    email: '',
    password: '',
  );

  UsuarioProvider() {
    getUsers();
    getTipeParameters();
    getTipeSensors();
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${ulr1}');
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
      usuario.lastName_1 = response.lastName_1;
      usuario.lastName_2 = response.lastName_2;
      usuario.email = response.email;
      usuario.password = response.password;

      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${ulr1}');
    }
  }

  Future<void> addUser(String cedula, String nombre, String apellido1,
      String apellido2, String email, String password, String permisos) async {
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
          'name_1': nombre,
          'LastName_1': apellido1,
          'LastName_2': apellido2,
          'email': email,
          'password': password,
          'Permisos': permisos
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
    }
  }

  Future<void> updateUser(String cedula, String nombre, String apellido1,
      String apellido2, String email, String password) async {
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
          'name_1': nombre,
          'LastName_1': apellido1,
          'LastName_2': apellido2,
          'email': email,
          'password': password
        }));
    if (resp.statusCode == 200) {
      notifyListeners();
      usuarios.clear();
      getUsers();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
    }
  }

  Future<void> deleteUser(String id) async {
    final url1 = Uri.http(urlapi, '/Usuarios/$id');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${ulr1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${ulr1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
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
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${url1}');
    }
  }
}
