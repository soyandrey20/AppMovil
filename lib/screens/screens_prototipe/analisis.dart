import 'package:empezar/importaciones/imports.dart';
import 'package:intl/intl.dart'; // Importa esta librería para formatear la fecha y hora

class AnalisisScreen extends StatefulWidget {
  const AnalisisScreen({super.key});

  @override
  State<AnalisisScreen> createState() => _AnalisisScreenState();
}

class _AnalisisScreenState extends State<AnalisisScreen> {
  late TextEditingController _txtFechaHoraController;
  var txtEmail = TextEditingController();
  var txtSensor = TextEditingController();
  var txtParametro = TextEditingController();
  String? selectedTipoParametro;

  @override
  void initState() {
    super.initState();
    _txtFechaHoraController = TextEditingController(
      text: DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _txtFechaHoraController.dispose();
    txtEmail.dispose();
    txtSensor.dispose();
    txtParametro.dispose();
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

    var tipoParaSensor = usuarioProvider.paraSensor;
    var tipoSensor = usuarioProvider.tipoSensor;
    var tipoPara = usuarioProvider.tipoParametro;

    List<String> tipoParaSensorStrings = tipoParaSensor
        .map((paraSensor) => paraSensor.idparaSensor.toString())
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 150,
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
                      TextFormField(
                        autocorrect: false,
                        controller: txtEmail,
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'sirve para *****',
                          labelText: 'Información del agua',
                          icon: const Icon(Icons.sensors),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _txtFechaHoraController,
                        enabled: false,
                        decoration: const InputDecoration(
                          hintText: ' ',
                          labelText: 'Fecha/hora de la medición',
                          icon: Icon(Icons.date_range),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _txtFechaHoraController.text =
                                    '${DateFormat('yyyy-MM-dd').format(pickedDate)} ${pickedTime.format(context)}';
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Seleccione el tipo de sensor',
                          labelText: 'Tipo del parámetro',
                          icon: const Icon(Icons.sensors),
                        ),
                        items: tipoParaSensorStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          buscar(
                              tipoParaSensor, tipoPara, newValue, tipoSensor);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        autocorrect: false,
                        controller: txtSensor,
                        decoration: InputDecorations.inputDecoration(
                          hintText: ' ',
                          labelText: 'Tipo de sensor',
                          icon: const Icon(Icons.sensors),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        enabled: false,
                        autocorrect: false,
                        controller: txtParametro,
                        decoration: InputDecorations.inputDecoration(
                          hintText: ' ',
                          labelText: 'Tipo de parámetro',
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
                              print(usuarioProvider.paraSensor.length);

                              for (var i = 0; i < tipoParaSensor.length; i++) {
                                print(
                                    usuarioProvider.paraSensor[i].idparaSensor);
                              }
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

  void buscar(
      List<ParametroSensor> tipoParaSensor,
      List<TipoParametro> tipoPara,
      String? newValue,
      List<TipoParametro> tipoSensor) {
    return setState(() {
      bool encontrado1 = false;
      for (var i = 0; i < tipoParaSensor.length && !encontrado1; i++) {
        for (var j = 0; j < tipoPara.length && !encontrado1; j++) {
          if (tipoParaSensor[int.parse(newValue!) - 1].idparaSensor ==
                  int.parse(newValue) &&
              tipoParaSensor[int.parse(newValue!) - 1].idParametro ==
                  tipoPara[j].id) {
            txtParametro.text = tipoPara[j].descripcion.toString();

            encontrado1 = true;
            break;
          }
        }
      }
      bool encontrado = false;
      for (var i = 0; i < tipoParaSensor.length && !encontrado; i++) {
        for (var j = 0; j < tipoSensor.length && !encontrado; j++) {
          if (tipoParaSensor[int.parse(newValue!) - 1].idparaSensor ==
                  int.parse(newValue) &&
              tipoParaSensor[int.parse(newValue!) - 1].idSensor ==
                  tipoSensor[j].id) {
            txtSensor.text = tipoSensor[j].descripcion.toString();

            encontrado = true;
            break;
          }
        }
      }

      newValue;
    });
  }
}
