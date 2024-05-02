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
                Text('Análisis del agua',
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
                          items: tipoParametroStrings.map((String value) {
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
                        Column(
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledColor: Colors.grey,
                              color: Colors.deepPurple,
                              onPressed: () async {},
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
