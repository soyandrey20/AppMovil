import 'package:empezar/importaciones/imports.dart';

Future<void> registerUser(
    UsuarioProvider usuarioProvider,
    TextEditingController txtEmail,
    TextEditingController txtCedula,
    TextEditingController txtLastName2,
    BuildContext context,
    TextEditingController txtEmailConfirm,
    TextEditingController txtPassword,
    TextEditingController txtPasswordConfirm,
    TextEditingController txtName1,
    TextEditingController txtName2,
    TextEditingController txtLastName1,
    String permisos) async {
  var user = usuarioProvider.usuarios;
  var emailExist = 0;
  var cedulaExist = 0;

  for (var i = 0; i < user.length; i++) {
    if (user[i].email == txtEmail.text) {
      emailExist = 1;
    } else if (user[i].cedula == txtCedula.text) {
      cedulaExist = 1;
    }
  }
  if (txtLastName2.text.isEmpty) {
    txtLastName2.text = 'N/A';
  }
  if (txtName2.text.isEmpty) {
    txtName2.text = 'N/A';
  }

  if (emailExist == 1) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('El correo ya se encuentra registrado'),
      ),
    );
  } else if (cedulaExist == 1) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La cedula ya se encuentra registrada'),
      ),
    );
  } else if (txtEmail.text == txtEmailConfirm.text &&
      txtPassword.text == txtPasswordConfirm.text &&
      txtName1.text.isNotEmpty &&
      txtLastName1.text.isNotEmpty &&
      cedulaExist == 0 &&
      emailExist == 0) {
    await usuarioProvider.addUser(
        txtCedula.text,
        txtName1.text,
        txtName2.text,
        txtLastName1.text,
        txtLastName2.text,
        txtEmail.text,
        txtPassword.text,
        permisos,
        true);
    emailExist = 0;
    Navigator.pushReplacementNamed(context, 'home');
  } else {
    emailExist = 0;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Los datos no coinciden, por favor verifique'),
      ),
    );
  }
}
