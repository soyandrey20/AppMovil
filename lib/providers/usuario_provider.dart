import 'dart:convert';

import 'package:empezar/constants.dart';
import 'package:empezar/models/registro.dart';
import 'package:empezar/models/usuario.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

const urlapi = url;

class Usuario_provider with ChangeNotifier {
  List<Usuario> usuarios = [];
  List<Registro> registros = [];

  Usuario_provider() {
    getUsers();
    // getUser();
  }

  getUsers() async {
    final ulr1 = Uri.http(urlapi, '/usuarios');
    final resp = await http.get(ulr1, headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-cedentials': 'true',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    final response = usuarioFromJson(resp.body);
    usuarios = response;
    notifyListeners();
  }

  // getUser() async {
  //   final ulr1 = Uri.http(urlapi, '/Usuarios/:id');
  //   final resp = await http.get(ulr1, headers: {
  //     'Access-Control-Allow-Origin': '*',
  //     'Access-Control-Allow-cedentials': 'true',
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });

  //   registroFromJson(resp.body);
  // }

  Future<void> addUser(String nombre, String apellido1, String apellido2,
      String Email, String Password) async {
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
          'email': Email,
          'password': Password
        }));

    print(resp.body);
    notifyListeners();
  }

  Future<void> UpdateUser() async {}
}



// Future<void> sendmail(String email) async {
//   try {
//     var message = Message();
//     message.subject = 'Hello from the other side!';
//     message.text = 'Hello from the other side!';
//     message.from = Address('burgaandrey@gmail.com');
//     message.recipients.add('burgaandrey@gmail.com');
//     var stmpServer = gmailSaslXoauth2(userEmail, accessToken)
//   } catch (e) {}
// }
