import 'package:empezar/importaciones/imports.dart';

class TipoParametroScreen extends StatefulWidget {
  const TipoParametroScreen({super.key});

  @override
  State<TipoParametroScreen> createState() => _TipoParametroScreenState();
}

class _TipoParametroScreenState extends State<TipoParametroScreen> {
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
        title: const Text('Opciones'),
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
              margin: EdgeInsetsDirectional.all(8),
              child: Text('Opciones'),
            ),
            ListTile(
              title: const Text('Menu principal'),
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              title: const Text('Análisis'),
              onTap: () {
                Navigator.pushNamed(context, 'analisis');
              },
            ),
            ListTile(
              title: const Text('Tipo de sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'tipo_sensor');
              },
            ),
            ListTile(
              title: const Text('sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'sensor');
              },
            ),
            ListTile(
              title: const Text('parametro'),
              onTap: () {
                Navigator.pushNamed(context, 'parametros');
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

    var txtDescripcion = TextEditingController();

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
                Text('Tipo de parámetro',
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
                        controller: txtDescripcion,
                        decoration: InputDecorations.inputDecoration(
                          labelText: 'Información del tipo de parámetro',
                          icon: const Icon(Icons.sensors),
                          hintText: '',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Colors.deepPurple,
                            onPressed: () async {
                              if (txtDescripcion.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Campo vacío'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Tipo de parametro agregado correctamente'),
                                  ),
                                );

                                await usuarioProvider
                                    .addTipeParametro(txtDescripcion.text);
                                usuarioProvider.getTipeParameters();
                                Navigator.pushReplacementNamed(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    'home');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              child: const Text(
                                'Agregar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          // MaterialButton(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   disabledColor: Colors.grey,
                          //   color: Colors.red, // Color de eliminación
                          //   onPressed: () {
                          //     var existingAcount = 1;

                          //     for (var i = 0; i < users.length; i++) {
                          //       if (users[i].email == txtEmail.text) {
                          //         existingAcount = 0;
                          //         usuarioProvider.getUser(users[i].cedula);
                          //         break;
                          //       } else {
                          //         existingAcount;
                          //       }
                          //     }

                          //     if (existingAcount == 0) {
                          //       usuarioProvider.deleteUser(users[0].cedula);
                          //     } else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(
                          //           content: Text(
                          //               'Correo no registrado, intente de nuevo'),
                          //         ),
                          //       );
                          //     }
                          //   },
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 30, vertical: 12),
                          //     child: const Text(
                          //       '',
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 18),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '¿Deseas eliminar?',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: ' Click aquí',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  usuarioProvider.tipoSensor;
                                  Navigator.pushReplacementNamed(
                                      context, 'eliminar_tpp');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
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
}
