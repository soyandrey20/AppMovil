import 'package:empezar/importaciones/imports.dart';

class RestoretPasswordScreen extends StatefulWidget {
  const RestoretPasswordScreen({super.key});

  @override
  State<RestoretPasswordScreen> createState() => _RestoretPasswordScreenState();
}

class _RestoretPasswordScreenState extends State<RestoretPasswordScreen> {
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
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var txtPassword = TextEditingController();
    var txtPasswordConfirm = TextEditingController();

    var user = usuarioProvider.usuario;

    var nombre = user.name_1;
    var apellido1 = user.lastName_1;
    var apellido2 = user.lastName_2;
    var email = user.email;
    var cedula = user.cedula;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
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
                  height: 40,
                ),
                Text('Cambiar contraseña',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          controller: txtPassword,
                          decoration: InputDecorations.inputDecoration(
                            hintText: '*********',
                            labelText: 'Digite nueva contraseña',
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
                          height: 5,
                        ),
                        TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          controller: txtPasswordConfirm,
                          decoration: InputDecorations.inputDecoration(
                            hintText: '*********',
                            labelText: 'Confirmar contraseña',
                            icon: const Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            return (txtPassword.text == txtPasswordConfirm.text)
                                ? null
                                : 'Las contraseñas no coinciden';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledColor: Colors.grey,
                          color: Colors.deepPurple,
                          onPressed: () {
                            var password = txtPassword.text;
                            usuarioProvider.updateUser(cedula, nombre,
                                apellido1, apellido2, email, password);
                            Navigator.pushReplacementNamed(context, 'login');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: const Text(
                              'Confirmar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: const Text(
                'Volver al inicio',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
