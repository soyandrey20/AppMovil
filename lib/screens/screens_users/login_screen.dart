import 'package:empezar/importaciones/imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var txtCedula = TextEditingController();
  var txtPassword = TextEditingController();

  @override
  void dispose() {
    txtCedula.dispose();
    txtPassword.dispose();
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
                Navigator.pushReplacementNamed(context, 'wellcome');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

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
                Text('Login',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        identification(txtCedula: txtCedula),
                        const SizedBox(
                          height: 40,
                        ),
                        password(txtPassword: txtPassword),
                        const forgotPassword(),
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
                            loginUser(usuarioProvider, txtCedula, txtPassword,
                                context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: const Text('Ingresar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const register(),
        ],
      ),
    );
  }
}

class register extends StatelessWidget {
  const register({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '¿No tienes cuenta?',
        style: const TextStyle(color: Colors.black, fontSize: 15),
        children: [
          TextSpan(
            text: ' Registrate',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 18),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(context, 'register');
              },
          ),
        ],
      ),
    );
  }
}

class forgotPassword extends StatelessWidget {
  const forgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'forgot_password');
        },
        child: const Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}

class password extends StatelessWidget {
  const password({
    super.key,
    required this.txtPassword,
  });

  final TextEditingController txtPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: txtPassword,
      decoration: InputDecorations.inputDecoration(
        hintText: '*********',
        labelText: 'Contraseña',
        icon: const Icon(Icons.lock_outline),
      ),
    );
  }
}

class identification extends StatelessWidget {
  const identification({
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
        hintText: '00000000',
        labelText: '# Cédula',
        icon: const Icon(Icons.assignment_ind_outlined),
      ),
      validator: (value) {
        String pattern = r'^[0-9]{10}$';
        RegExp regExp = RegExp(pattern);
        return regExp.hasMatch(value ?? '') ? null : '# Cédula no valido';
      },
    );
  }
}
