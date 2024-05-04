import 'package:empezar/importaciones/imports.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  var txtCedula = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var txtName1 = TextEditingController();
  var txtName2 = TextEditingController();
  var txtLastName1 = TextEditingController();
  var txtLastName2 = TextEditingController();

  @override
  void dispose() {
    txtCedula.dispose();
    txtEmail.dispose();
    txtPassword.dispose();
    txtName1.dispose();
    txtName2.dispose();
    txtLastName1.dispose();
    txtLastName2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.green.shade300,
        child: Stack(
          children: [
            cajaPurpura(size),
            loginForm(context),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Regresar'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var user = usuarioProvider.usuario;

    txtName1.text = user.name_1;
    txtName2.text = user.name_2;
    txtLastName1.text = user.lastName_1;
    txtLastName2.text = user.lastName_2;
    txtEmail.text = user.email;
    txtPassword.text = user.password;
    txtCedula.text = user.cedula;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 220,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text('Mi perfil',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      IdentificationUser(txtCedula: txtCedula),
                      const SizedBox(
                        height: 10,
                      ),
                      NamesUser(txtName1: txtName1, txtName2: txtName2),
                      const SizedBox(
                        height: 10,
                      ),
                      lastNameAdmin(txtLastName1, txtLastName2),
                      const SizedBox(
                        height: 10,
                      ),
                      EmailUser(txtEmail: txtEmail),
                      PasswordUser(txtPassword: txtPassword),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10), // Adjust padding as needed
                          child: TextButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text(
                              'Desactivar cuenta',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            onPressed: () {
                              Deshabilitar(context, txtCedula, usuarioProvider);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> Deshabilitar(BuildContext context,
      TextEditingController txtCedula, UsuarioProvider usuarioProvider) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content:
              const Text('¿Estás seguro de que deseas Eliminar este usuario?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  usuarioProvider.deleteUser(txtCedula.text, false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Usuario eliminado correctamente'),
                    ),
                  );
                });
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Row lastNameAdmin(
      TextEditingController txtLastName1, TextEditingController txtLastName2) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: false,
            controller: txtLastName1,
            decoration: InputDecorations.inputDecoration(
              hintText: ' ',
              labelText: 'Primer Apellido*',
              icon: const Icon(Icons.person),
            ),
            validator: (value) {
              String pattern = r'^[A-Za-z]+';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Apellido no válido';
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: false,
            controller: txtLastName2,
            decoration: InputDecorations.inputDecoration(
              hintText: ' ',
              labelText: 'Segundo Apellido',
              icon: const Icon(Icons.person_outline),
            ),
          ),
        ),
      ],
    );
  }
}

class IdentificationUser extends StatelessWidget {
  const IdentificationUser({
    super.key,
    required this.txtCedula,
  });

  final TextEditingController txtCedula;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      autocorrect: false,
      controller: txtCedula,
      decoration: InputDecorations.inputDecoration(
        hintText: '00000000',
        labelText: '# Cédula*',
        icon: const Icon(Icons.assignment_ind_outlined),
      ),
      validator: (value) {
        String pattern = r'^[0-9]{10}$';
        RegExp regExp = RegExp(pattern);
        return regExp.hasMatch(value ?? '') ? null : '# Cédula no válido';
      },
    );
  }
}

class NamesUser extends StatelessWidget {
  const NamesUser({
    super.key,
    required this.txtName1,
    required this.txtName2,
  });

  final TextEditingController txtName1;
  final TextEditingController txtName2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: false,
            controller: txtName1,
            decoration: InputDecorations.inputDecoration(
              hintText: ' ',
              labelText: 'Primer nombre*',
              icon: const Icon(Icons.person),
            ),
            validator: (value) {
              String pattern = r'^[A-Za-z]+';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'Nombre no válido';
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            enabled: false,
            autocorrect: false,
            controller: txtName2,
            decoration: InputDecorations.inputDecoration(
              hintText: ' ',
              labelText: 'Segundo nombre',
              icon: const Icon(Icons.person_outline),
            ),
          ),
        ),
      ],
    );
  }
}

class EmailUser extends StatelessWidget {
  const EmailUser({
    super.key,
    required this.txtEmail,
  });

  final TextEditingController txtEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          controller: txtEmail,
          decoration: InputDecorations.inputDecoration(
            hintText: 'ejemplo@gmail.com',
            labelText: 'Correo*',
            icon: const Icon(Icons.alternate_email_rounded),
          ),
          validator: (value) {
            String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,}$';
            RegExp regExp = RegExp(pattern);
            return regExp.hasMatch(value ?? '') ? null : 'Correo no válido';
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class PasswordUser extends StatelessWidget {
  const PasswordUser({
    super.key,
    required this.txtPassword,
  });

  final TextEditingController txtPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          enabled: false,
          autocorrect: false,
          obscureText: true,
          controller: txtPassword,
          decoration: InputDecorations.inputDecoration(
            hintText: '*********',
            labelText: 'Contraseña*',
            icon: const Icon(Icons.lock_outline),
          ),
          validator: (value) {
            String pattern =
                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
            return RegExp(pattern).hasMatch(value ?? '')
                ? null
                : 'La contraseña debe tener al menos 8 caracteres';
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
