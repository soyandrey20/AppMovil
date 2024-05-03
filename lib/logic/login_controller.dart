 import 'package:empezar/importaciones/imports.dart';

 
 
 void loginUser(
      UsuarioProvider usuarioProvider,
      TextEditingController txtCedula,
      TextEditingController txtPassword,
      BuildContext context) {
    var user = usuarioProvider.usuarios;

    var existingAcount = 1;

    for (var i = 0; i < user.length; i++) {
      if (user[i].cedula == txtCedula.text &&
          user[i].password == txtPassword.text) {
        existingAcount = 0;

        break;
      } else {
        existingAcount = 1;
      }
    }

    if (existingAcount == 0) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos incorrectos, intente de nuevo')));
    }
  }
