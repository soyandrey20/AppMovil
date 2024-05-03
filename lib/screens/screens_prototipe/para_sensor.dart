import 'package:empezar/importaciones/imports.dart';

class ParaSensorScreen extends StatefulWidget {
  const ParaSensorScreen({super.key});

  @override
  State<ParaSensorScreen> createState() => _ParaSensorScreenState();
}

class _ParaSensorScreenState extends State<ParaSensorScreen> {
  String? selectedTipoParametro;
  String? selectedTipoSensor;

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
              title: const Text('Menu principal'),
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              title: const Text('Tipo de sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'tipo_sensor');
              },
            ),
            ListTile(
              title: const Text('Sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'sensor');
              },
            ),
            ListTile(
              title: const Text('Tipo de parámetro'),
              onTap: () {
                Navigator.pushNamed(context, 'tipo_parametro');
              },
            ),
            ListTile(
              title: const Text('Parámetros'),
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

    var tipoParametro = usuarioProvider.tipoParametro;

    var tipoSensor = usuarioProvider.tipoSensor;

    List<String> tipoParametroStrings =
        tipoParametro.map((parametro) => parametro.descripcion).toList();

    List<String> tipoSensorStrings =
        tipoSensor.map((sensor) => sensor.descripcion).toList();

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
                Text('Análisis del agua',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de sensor',
                          labelText: 'Tipo del sensor',
                          icon: const Icon(Icons.sensors),
                        ),
                        items: tipoSensorStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTipoSensor = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de parámetro',
                          labelText: 'Tipo del parámetro',
                          icon: const Icon(Icons.sensors),
                        ),
                        items: tipoParametroStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTipoParametro = newValue;
                          });
                        },
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
                              int idSensor = tipoSensor.length + 1;
                              int idParametro = tipoParametro.length + 1;
                              for (var i = 0; i < tipoSensor.length; i++) {
                                if (tipoSensor[i].descripcion ==
                                    selectedTipoSensor) {
                                  idSensor = tipoSensor[i].id;
                                }
                              }
                              for (var i = 0; i < tipoParametro.length; i++) {
                                if (tipoParametro[i].descripcion ==
                                    selectedTipoParametro) {
                                  idParametro = tipoParametro[i].id;
                                }
                              }

                              await usuarioProvider.addParaSensor(
                                  idSensor, idParametro);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              child: const Text(
                                'Analizar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
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
                                      context, 'eliminar_tss');
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
