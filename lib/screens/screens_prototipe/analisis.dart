import 'package:empezar/importaciones/imports.dart';
import 'package:intl/intl.dart'; // Importa esta librería para formatear la fecha y hora

class AnalisisScreen extends StatefulWidget {
  const AnalisisScreen({super.key});

  @override
  State<AnalisisScreen> createState() => _AnalisisScreenState();
}

class _AnalisisScreenState extends State<AnalisisScreen> {
  late TextEditingController _txtFechaHoraController;
  var txtInformacion = TextEditingController();
  var txtSensor = TextEditingController();
  var txtParametro = TextEditingController();
  String? selectedTipoParametro;
  String? selectedFinca;

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
    txtInformacion.dispose();
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

    var finca = usuarioProvider.fincas;

    List<String> tipoParaSensorStrings = tipoParaSensor
        .map((paraSensor) => paraSensor.idparaSensor.toString())
        .toList();
    List<String> fincasStrings =
        finca.map((finca) => finca.nombreFinca).toList();

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
                        controller: txtInformacion,
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
                          hintText: 'Seleccione la finca',
                          labelText: 'Finca',
                          icon: const Icon(Icons.sensors),
                        ),
                        items: fincasStrings.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFinca = newValue;
                          });
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
                              if (selectedFinca == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Seleccione la finca'),
                                  ),
                                );
                                return;
                              } else if (txtInformacion.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Ingrese la información del agua'),
                                  ),
                                );
                                return;
                              } else {
                                usuarioProvider.llamarArduino(
                                    _txtFechaHoraController.text,
                                    selectedFinca!,
                                    txtInformacion.text,
                                    usuarioProvider.usuario.email,
                                    usuarioProvider.usuario.nombre_1,
                                    usuarioProvider.usuario.lastName_1);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Analisis enviados correctamente al correo registrado'),
                                  ),
                                );
                                txtInformacion.clear();
                                selectedFinca = null;
                                selectedTipoParametro = null;
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
              tipoParaSensor[int.parse(newValue) - 1].idParametro ==
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
              tipoParaSensor[int.parse(newValue) - 1].idSensor ==
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
