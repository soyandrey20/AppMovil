import 'package:empezar/importaciones/imports.dart';

void restorePassword(TextEditingController txtCedula,
    UsuarioProvider usuarioProvider, BuildContext context) {
  var existingCount = 0;
  var users = usuarioProvider.usuarios;

  for (var i = 0; i < users.length; i++) {
    if (users[i].cedula == txtCedula.text) {
      existingCount = 1;
      usuarioProvider.getUser(users[i].cedula);

      break;
    }
  }

  if (existingCount == 1) {
    usuarioProvider.restorePasword(txtCedula.text);
    Navigator.pushReplacementNamed(context, 'login');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contraseña enviada al correo'),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuario no registrado en la base de datos'),
      ),
    );
  }
}
