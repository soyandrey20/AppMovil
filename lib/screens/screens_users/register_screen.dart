import 'package:empezar/importaciones/imports.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
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
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : '# Cédula no válido';
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
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
                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'Nombre no válido';
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
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
                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'Apellido no válido';
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // Correo electrónico y confirmación de correo electrónico
                        Column(
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
                                String pattern =
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,}$';
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value ?? '')
                                    ? null
                                    : 'Correo no válido';
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
                        ),
                        const SizedBox(
                            height:
                                10), // Espacio entre la confirmación de correo electrónico y la contraseña

                        // Contraseña y confirmación de contraseña
                        Column(
                          children: [
                            TextFormField(
                              autocorrect: false,
                              obscureText: true,
                              controller: txtPassword,
                              decoration: InputDecorations.inputDecoration(
                                hintText: '*********',
                                labelText: 'Digite una contraseña*',
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
                                return (txtPassword.text ==
                                        txtPasswordConfirm.text)
                                    ? null
                                    : 'Las contraseñas no coinciden';
                              },
                            ),
                          ],
                        ),
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

                            if (emailExist == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'El correo ya se encuentra registrado'),
                                ),
                              );
                            } else if (cedulaExist == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'La cedula ya se encuentra registrada'),
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
                                  txtLastName1.text,
                                  txtLastName2.text,
                                  txtEmail.text,
                                  txtPassword.text,
                                  permisos);
                              emailExist = 0;
                              Navigator.pushReplacementNamed(context, 'home');
                            } else {
                              emailExist = 0;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Los datos no coinciden, por favor verifique'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: const Text('Registrarse',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
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

  SafeArea iconoPersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container cajaPurpura(Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 74, 167, 239),
            Color.fromARGB(255, 74, 167, 239),
          ],
        ),
      ),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: burbuja(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: burbuja(),
          ),
          Positioned(
            top: -50,
            right: -20,
            child: burbuja(),
          ),
          Positioned(
            bottom: -50,
            right: 10,
            child: burbuja(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: burbuja(),
          ),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 23, 113, 247).withOpacity(0.3),
      ),
    );
  }
}
