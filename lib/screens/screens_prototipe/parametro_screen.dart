import 'package:empezar/importaciones/imports.dart';

class ParametroScreen extends StatefulWidget {
  const ParametroScreen({super.key});

  @override
  State<ParametroScreen> createState() => _ParametroScreenState();
}

class _ParametroScreenState extends State<ParametroScreen> {
  var txtRangoInferior = TextEditingController();
  var txtRangoSuperior = TextEditingController();

  String? selectedTipoParametro;
  @override
  void dispose() {
    txtRangoInferior.dispose();
    txtRangoSuperior.dispose();
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
              title: const Text('Analisis'),
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
              title: const Text('Sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'sensor');
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

    var tipoParametro = usuarioProvider.tipoParametro;

    List<String> tipoParametroStrings =
        tipoParametro.map((parametro) => parametro.descripcion).toList();

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
                Text('Información del parámetro',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de parámetro',
                          labelText: 'Tipo de parámetro',
                          icon: const Icon(Icons.sensors),
                        ),
                        value: selectedTipoParametro,
                        items: tipoParametroStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedTipoParametro = newValue;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        controller: txtRangoInferior,
                        decoration: InputDecorations.inputDecoration(
                          hintText: ' ',
                          labelText: 'Rango inferior',
                          icon: const Icon(Icons.sensors),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                        controller: txtRangoSuperior,
                        decoration: InputDecorations.inputDecoration(
                          hintText: ' ',
                          labelText: 'Rango superior',
                          icon: const Icon(Icons.sensors),
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
                              if (selectedTipoParametro == null) {
                                mostrarSnackBar(
                                    context, 'Seleccione el tipo de parámetro');
                                return;
                              }
                              if (txtRangoInferior.text.isEmpty) {
                                mostrarSnackBar(
                                    context, 'Ingrese el rango inferior');
                                return;
                              }
                              if (txtRangoSuperior.text.isEmpty) {
                                mostrarSnackBar(
                                    context, 'Ingrese el rango superior');
                                return;
                              }
                              int id = 1;
                              //se recorre la lista de tipos de sensor para obtener el id
                              for (int i = 0; i < tipoParametro.length; i++) {
                                if (tipoParametro[i].descripcion ==
                                    selectedTipoParametro) {
                                  id = tipoParametro[i].id;
                                }
                              }

                              print('id: $id');
                              await usuarioProvider.addParametro(
                                txtRangoInferior.text,
                                txtRangoSuperior.text,
                                id,
                              );
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

  void mostrarSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }
}
