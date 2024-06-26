import 'package:empezar/importaciones/imports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var txtCedula = TextEditingController();
  var txtEmail = TextEditingController();
  var txtEmailConfirm = TextEditingController();
  var txtPassword = TextEditingController();
  var txtPasswordConfirm = TextEditingController();
  var txtName1 = TextEditingController();
  var txtName2 = TextEditingController();
  var txtLastName1 = TextEditingController();
  var txtLastName2 = TextEditingController();
  var permisos = 'usuario';
  String? selectedTipoPersona;

  @override
  void dispose() {
    txtCedula.dispose();
    txtEmail.dispose();
    txtEmailConfirm.dispose();
    txtPassword.dispose();
    txtPasswordConfirm.dispose();
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
            iconoPersona(),
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
                Navigator.pushReplacementNamed(context, 'login');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    var tipoPersonas = usuarioProvider.tpPersona;

    List<String> tipoPersonasStrings = tipoPersonas
        .map((paraSensor) => paraSensor.descripcion.toString())
        .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 130,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  height: 5,
                ),
                Text('Registro',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      IdentificationAdmin(txtCedula: txtCedula),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de persona',
                          labelText: 'Tipo de persona*',
                          icon: const Icon(Icons.person),
                        ),
                        items: tipoPersonasStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTipoPersona = tipoPersonasStrings
                                .indexOf(newValue!)
                                .toString();
                          });
                        },
                      ),
                      Names(txtName1: txtName1, txtName2: txtName2),
                      const SizedBox(
                        height: 10,
                      ),

                      apellidos(txtLastName1, txtLastName2),
                      const SizedBox(
                        height: 10,
                      ),

                      // Correo electrónico y confirmación de correo electrónico
                      Email(
                          txtEmail: txtEmail, txtEmailConfirm: txtEmailConfirm),
                      const SizedBox(
                          height:
                              10), // Espacio entre la confirmación de correo electrónico y la contraseña

                      // Contraseña y confirmación de contraseña
                      Password(
                          txtPassword: txtPassword,
                          txtPasswordConfirm: txtPasswordConfirm),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurple,
                        onPressed: () async {
                          await registerUser(
                            usuarioProvider,
                            txtEmail,
                            txtCedula,
                            txtLastName2,
                            context,
                            txtEmailConfirm,
                            txtPassword,
                            txtPasswordConfirm,
                            txtName1,
                            txtName2,
                            txtLastName1,
                            selectedTipoPersona!,
                            permisos,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: const Text('Registrarse',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              text: '¿Ya tienes cuenta?',
              style: const TextStyle(color: Colors.black, fontSize: 15),
              children: [
                TextSpan(
                  text: ' Iniciar sesión',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 98, 51, 226), fontSize: 18),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Row apellidos(
      TextEditingController txtLastName1, TextEditingController txtLastName2) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.name,
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
            keyboardType: TextInputType.name,
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

class IdentificationAdmin extends StatelessWidget {
  const IdentificationAdmin({
    super.key,
    required this.txtCedula,
  });

  final TextEditingController txtCedula;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      autocorrect: false,
      controller: txtCedula,
      decoration: InputDecorations.inputDecoration(
        hintText: '########',
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

class Names extends StatelessWidget {
  const Names({
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
            keyboardType: TextInputType.name,
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
            keyboardType: TextInputType.name,
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

class Email extends StatelessWidget {
  const Email({
    super.key,
    required this.txtEmail,
    required this.txtEmailConfirm,
  });

  final TextEditingController txtEmail;
  final TextEditingController txtEmailConfirm;

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
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          controller: txtEmailConfirm,
          decoration: InputDecorations.inputDecoration(
            hintText: 'ejemplo@gmail.com',
            labelText: 'Confirmar correo*',
            icon: const Icon(Icons.alternate_email_rounded),
          ),
          validator: (value) {
            return (txtEmail.text == txtEmailConfirm.text)
                ? null
                : 'Los correos no coinciden';
          },
        ),
      ],
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    super.key,
    required this.txtPassword,
    required this.txtPasswordConfirm,
  });

  final TextEditingController txtPassword;
  final TextEditingController txtPasswordConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autocorrect: false,
          obscureText: true,
          controller: txtPassword,
          decoration: InputDecorations.inputDecoration(
            hintText: '*********',
            labelText: 'Dígite una contraseña*',
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
        TextFormField(
          autocorrect: false,
          obscureText: true,
          controller: txtPasswordConfirm,
          decoration: InputDecorations.inputDecoration(
            hintText: '*********',
            labelText: 'Confirmar contraseña*',
            icon: const Icon(Icons.lock_outline),
          ),
          validator: (value) {
            return (txtPassword.text == txtPasswordConfirm.text)
                ? null
                : 'Las contraseñas no coinciden';
          },
        ),
      ],
    );
  }
}
