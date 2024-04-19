import 'dart:convert';

import 'package:empezar/constants.dart';
import 'package:empezar/models/registro.dart';
import 'package:empezar/models/usarioo.dart';
import 'package:empezar/models/usuario.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class UsuarioProvider with ChangeNotifier {
  List<Usuario> usuarios = [];

  List<Registro> registros = [];

  List<Usuarioo> usuarioo = [];

  var idd = '';

  Usuarioo usuario = Usuarioo(
    name1: '',
    lastName1: '',
    lastName2: '',
    email: '',
    password: '',
  );

  UsuarioProvider() {
    getUsers();
  }

  Future<void> getUsers() async {
    final ulr1 = Uri.http(urlapi, '/usuarios');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final response = usuarioFromJson(resp.body);
    if (resp.statusCode == 200) {
      usuarios = response;
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

      usuario.name1 = response.name1;
      usuario.lastName1 = response.lastName1;
      usuario.lastName2 = response.lastName2;
      usuario.email = response.email;
      usuario.password = response.password;

      notifyListeners();
    } else {
      // Manejar el caso en que la solicitud no fue exitosa
      print('Error en la solicitud: ${resp.statusCode} ${resp.body} ${ulr1}');
    }
  }

  Future<void> addUser(String nombre, String apellido1, String apellido2,
      String email, String password, String permisos) async {
    final url1 = Uri.http(urlapi, '/Registros');

    final resp = await http.post(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
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

  Future<void> updateUser(String nombre, String apellido1, String apellido2,
      String email, String password) async {
    final url1 = Uri.http(urlapi, '/Usuarios/$idd');
    final resp = await http.put(url1,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-cedentials': 'true',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id': idd,
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

  Future<void> deleteUser(int id) async {
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
}
