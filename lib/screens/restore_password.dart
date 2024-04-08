import 'package:empezar/providers/usuario_provider.dart';
import 'package:empezar/widget/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Provider.of<Usuario_provider>(context);

    var txtPassword = TextEditingController();
    var txtPasswordConfirm = TextEditingController();

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
                Container(
                  child: Form(
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
                                icon: const Icon(Icons.lock_outline)),
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
                                icon: const Icon(Icons.lock_outline)),
                            validator: (value) {
                              return (txtPassword.text ==
                                      txtPasswordConfirm.text)
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
                            onPressed: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              child: const Text('Confirmar',
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
