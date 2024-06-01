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
    String selectedTipoPersona,
    String permisos) async {
  var persona = usuarioProvider.persona;

  var emailExist = 0;
  var cedulaExist = 0;

  for (var i = 0; i < persona.length; i++) {
    if (persona[i].email == txtEmail.text) {
      emailExist = 1;
    } else if (persona[i].cedula == txtCedula.text) {
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
        content: Text('La cédula ya se encuentra registrada'),
      ),
    );
  } else if (txtEmail.text == txtEmailConfirm.text &&
      txtPassword.text == txtPasswordConfirm.text &&
      txtName1.text.isNotEmpty &&
      txtLastName1.text.isNotEmpty &&
      cedulaExist == 0 &&
      emailExist == 0) {
    await usuarioProvider.addPersona(
        txtCedula.text,
        int.parse(selectedTipoPersona) + 1,
        txtName1.text,
        txtName2.text,
        txtLastName1.text,
        txtLastName2.text,
        txtEmail.text,
        txtPassword.text,
        permisos,
        true);
    emailExist = 0;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuario registrado con éxito'),
      ),
    );
    Navigator.pushReplacementNamed(context, 'analisis');
  } else {
    emailExist = 0;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Los datos no coinciden, por favor verifique'),
      ),
    );
  }
}
