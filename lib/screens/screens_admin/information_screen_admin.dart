import 'package:empezar/importaciones/imports.dart';

class InformationScreenAdmin extends StatefulWidget {
  const InformationScreenAdmin({super.key});

  @override
  State<InformationScreenAdmin> createState() => _InformationScreenAdminState();
}

class _InformationScreenAdminState extends State<InformationScreenAdmin> {
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
      appBar: AppBar(
        title: const Text('Regresar'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login_admin');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var users = usuarioProvider.usuarios;
    var txtCedula = TextEditingController();

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
                Text('Información de usuario',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        controller: txtCedula,
                        decoration: InputDecorations.inputDecoration(
                          hintText: '00000000',
                          labelText: '# Cedula',
                          icon: const Icon(Icons.assignment_ind_outlined),
                        ),
                        validator: (value) {
                          String pattern = r'^[0-9]{10}$';
                          RegExp regExp = RegExp(pattern);
                          return regExp.hasMatch(value ?? '')
                              ? null
                              : '# Cedula no valido';
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
                                if (users[i].cedula == txtCedula.text) {
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
                                        'Cedula no registrado, intente de nuevo'),
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
                          const SizedBox(
                            width: 25,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            disabledColor: Colors.grey,
                            color: Colors.red, // Color de eliminación

                            onPressed: () {
                              var existingAcount = 1;

                              for (var i = 0; i < users.length; i++) {
                                if (users[i].cedula == txtCedula.text) {
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
                                        'Cedula no registrado, intente de nuevo'),
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
