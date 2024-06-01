import 'package:empezar/importaciones/imports.dart';

void loginUser(UsuarioProvider usuarioProvider, TextEditingController txtCedula,
    TextEditingController txtPassword, BuildContext context) {
  var users = usuarioProvider.usuarios;

  var existingAcount = 1;

  for (var i = 0; i < users.length; i++) {
    if (users[i].cedula == txtCedula.text &&
        users[i].password == txtPassword.text &&
        users[i].estado == true) {
      existingAcount = 0;

      break;
    } else {
      existingAcount = 1;
    }
  }

  if (existingAcount == 0) {
    Navigator.pushReplacementNamed(context, 'analisis');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos incorrectos, intente de nuevo'),
      ),
    );
  }
}
