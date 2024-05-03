import 'package:empezar/importaciones/imports.dart';

class TipoSensorEliminarScreen extends StatefulWidget {
  const TipoSensorEliminarScreen({super.key});

  @override
  State<TipoSensorEliminarScreen> createState() =>
      _TipoSensorEliminarScreenState();
}

class _TipoSensorEliminarScreenState extends State<TipoSensorEliminarScreen> {
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
        title: const Text('Regresar'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'tipo_sensor');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var tipoParametro = usuarioProvider.tipoSensor;

    List<String> tipoParametroStrings =
        tipoParametro.map((parametro) => parametro.descripcion).toList();

    String? selectedTipoParametro;

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
                Text('¿Desea eliminar el tipo de sensor?',
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
                          hintText: 'Seleccione el tipo de sensor',
                          labelText: 'Seleccione el tipo de sensor',
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
                          setState(() {
                            selectedTipoParametro = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Colors.red, // Color de eliminación
                            onPressed: () {
                              usuarioProvider
                                  .deleteTipeSensor('sirve para no sirve');
                              // if (selectedTipoParametro == null) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text(
                              //           'Por favor seleccionar un tipo de sensor disponible'),
                              //     ),
                              //   );
                              // } else {
                              //   usuarioProvider.deleteSensor('yg');
                              // }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              child: const Text(
                                'Confirmar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
