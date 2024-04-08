import 'package:empezar/providers/usuario_provider.dart';
import 'package:empezar/widget/input_decoration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final usuarioProvider = Provider.of<Usuario_provider>(context);
    var txtEmail = TextEditingController();
    var txtPassword = TextEditingController();

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
                Container(
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            controller: txtEmail,
                            decoration: InputDecorations.inputDecoration(
                                hintText: 'ejemplo@gmail.com',
                                labelText: 'Correo',
                                icon:
                                    const Icon(Icons.alternate_email_rounded)),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            autocorrect: false,
                            obscureText: true,
                            controller: txtPassword,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '*********',
                                labelText: 'contraseña',
                                icon: const Icon(Icons.lock_outline)),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'forgot_password');
                              },
                              child: const Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
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
                              var user = usuarioProvider.usuarios;

                              var ExistingAcount = 1;

                              for (var i = 0; i < user.length; i++) {
                                if (user[i].email == txtEmail.text &&
                                    user[i].password == txtPassword.text) {
                                  ExistingAcount = 0;

                                  break;
                                } else {
                                  ExistingAcount = 1;
                                }
                              }

                              if (ExistingAcount == 0) {
                                Navigator.pushReplacementNamed(context, 'home');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Datos incorrectos, intente de nuevo')));
                              }
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
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RichText(
            text: TextSpan(
              text: '¿No tienes cuenta?',
              style: const TextStyle(color: Colors.black, fontSize: 15),
              children: [
                TextSpan(
                  text: ' Registrate',
                  style:
                      const TextStyle(color: Colors.blueAccent, fontSize: 18),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SafeArea iconoPersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
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
            Color.fromARGB(199, 52, 39, 152),
            Color.fromARGB(199, 52, 39, 152),
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
            child: Burbuja(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: Burbuja(),
          ),
          Positioned(
            top: -50,
            right: -20,
            child: Burbuja(),
          ),
          Positioned(
            bottom: -50,
            right: 10,
            child: Burbuja(),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: Burbuja(),
          ),
        ],
      ),
    );
  }

  Container Burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
      ),
    );
  }
}
