import 'package:empezar/importaciones/imports.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  //definir controladores
  var txtDescripcion = TextEditingController();
  String? selectedTipoSensor;

  //al cerrar la pantalla se limpian los controladores
  @override
  void dispose() {
    txtDescripcion.dispose();
    super.dispose();
  }

//se crea la pantalla
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

//se crea el scaffold

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
      //se crea el appbar con el titulo y el icono de menu
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
      //se crea el drawer con las opciones de la pantalla
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
              title: const Text('parametro sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'para_sensor');
              },
            ),
            ListTile(
              title: const Text('Tipo de sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'tipo_sensor');
              },
            ),
            ListTile(
              title: const Text('Tipo de parámetro'),
              onTap: () {
                Navigator.pushNamed(context, 'tipo_parametro');
              },
            ),
            ListTile(
              title: const Text('Parámetro'),
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

//se crea el formulario de la pantalla
  SingleChildScrollView loginForm(BuildContext context) {
    //se obtiene el provider
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
//se obtiene los tipos de sensor
    var tipoSensor = usuarioProvider.tipoSensor;
//se crea una lista con los tipos de sensor
    List<String> tipoSensorStrings =
        tipoSensor.map((sensor) => sensor.descripcion).toList();
//se crea la pantalla con los campos de texto y los botones
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
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      //se crea una lista desplegable con los tipos de parámetros
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de parámetro',
                          labelText: 'Tipo de parámetro',
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
                      //se crea un campo de texto para la descripción del sensor
                      TextFormField(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'sirve para *****',
                          labelText: 'Información del sensor',
                          icon: const Icon(Icons.sensors),
                        ),
                        onChanged: (value) {
                          setState(() {
                            txtDescripcion.text = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
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
                              //se obtiene el id del tipo de sensor seleccionado
                              int id = 1;
                              //se recorre la lista de tipos de sensor para obtener el id
                              for (int i = 0; i < tipoSensor.length; i++) {
                                if (tipoSensor[i].descripcion ==
                                    selectedTipoSensor) {
                                  id = tipoSensor[i].id;
                                }
                              }
                              //se agrega el sensor
                              await usuarioProvider.addSensor(
                                  txtDescripcion.text, id);
                              //se redirige a la pantalla de home
                              Navigator.pushNamed(context, 'home');
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
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
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
