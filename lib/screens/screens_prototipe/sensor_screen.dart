import 'package:empezar/providers/usuario_provider.dart';
import 'package:empezar/widget/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
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
        title: const Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Opciones'),
            ),
            ListTile(
              title: const Text('Tipo de sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              title: const Text('Sensores'),
              onTap: () {
                Navigator.pushNamed(context, 'sensor');
              },
            ),
            ListTile(
              title: const Text('Parámetros'),
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
            ),
            ListTile(
              title: const Text('Tipo de parámetro'),
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var users = usuarioProvider.usuarios;
    var txtEmail = TextEditingController();

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
                Text('Información del sensor',
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
                          controller: txtEmail,
                          decoration: InputDecorations.inputDecoration(
                            hintText: 'sirve para *****',
                            labelText: 'Información del sensor',
                            icon: const Icon(Icons.sensors),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecorations.inputDecoration(
                            hintText: 'Seleccione el tipo de sensor',
                            labelText: 'Tipo de sensor',
                            icon: const Icon(Icons.sensors),
                          ),
                          items: const <String>[
                            'Sensor de temperatura',
                            'Sensor de humedad',
                            'Sensor de luz',
                            'Sensor de movimiento',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledColor: Colors.grey,
                              color: Colors.deepPurple,
                              onPressed: () async {
                                var existingAcount = 1;

                                for (var i = 0; i < users.length; i++) {
                                  if (users[i].email == txtEmail.text) {
                                    existingAcount = 0;
                                    usuarioProvider.getUser(users[i].cedula);
                                    break;
                                  } else {
                                    existingAcount;
                                  }
                                }

                                if (existingAcount == 0) {
                                  Navigator.pushReplacementNamed(
                                      context, 'home_admin');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Correo no registrado, intente de nuevo'),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                child: const Text(
                                  'Buscar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledColor: Colors.grey,
                              color: Colors.red, // Color de eliminación
                              onPressed: () {
                                var existingAcount = 1;

                                for (var i = 0; i < users.length; i++) {
                                  if (users[i].email == txtEmail.text) {
                                    existingAcount = 0;
                                    usuarioProvider.getUser(users[i].cedula);
                                    break;
                                  } else {
                                    existingAcount;
                                  }
                                }

                                if (existingAcount == 0) {
                                  usuarioProvider.deleteUser(users[0].cedula);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Correo no registrado, intente de nuevo'),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
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
