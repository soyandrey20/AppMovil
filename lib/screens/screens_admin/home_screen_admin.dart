import 'package:empezar/importaciones/imports.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
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
                Navigator.pushReplacementNamed(context, 'information_admin');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

    var txtcedula = TextEditingController();
    var txtEmail = TextEditingController();

    var txtPassword = TextEditingController();

    var txtName = TextEditingController();
    var txtLastName1 = TextEditingController();
    var txtLastName2 = TextEditingController();

    var user = usuarioProvider.usuario;

    txtName.text = user.name_1;
    txtLastName1.text = user.lastName_1;
    txtLastName2.text = user.lastName_2;
    txtEmail.text = user.email;
    txtPassword.text = user.password;
    txtcedula.text = user.cedula;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
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
                  height: 10,
                ),
                Text('Informacion del usuario',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: txtcedula,
                            enabled: false,
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
                                  : 'Nombre no valido';
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: txtName,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'nombre',
                              labelText: 'nombre',
                              icon: const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: txtLastName1,
                            enabled: false,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'Primer apellido',
                              labelText: 'Primer Apellido',
                              icon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              String pattern = r'^[A-Za-z]+';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'Apellido no valido';
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            controller: txtLastName2,
                            enabled: false,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'Segundo apellido',
                              labelText: 'Segundo Apellido',
                              icon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              String pattern = r'^[A-Za-z]+';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'Apellido no valido';
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            controller: txtEmail,
                            decoration: InputDecorations.inputDecoration(
                              hintText: 'ejemplo@gmail.com',
                              labelText: 'Correo',
                              icon: const Icon(Icons.alternate_email_rounded),
                            ),
                            validator: (value) {
                              String pattern =
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,}$';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'Correo no valido';
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            autocorrect: false,
                            obscureText: true,
                            controller: txtPassword,
                            enabled: false,
                            decoration: InputDecorations.inputDecoration(
                              hintText: '*********',
                              labelText: 'Digite una contraseña',
                              icon: const Icon(Icons.lock_outline),
                            ),
                            validator: (value) {
                              String pattern =
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                              return RegExp(pattern).hasMatch(value ?? '')
                                  ? null
                                  : 'La contraseña debe tener al menos 8 caracteres';
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledColor: Colors.grey,
                            color: Colors.deepPurple,
                            onPressed: () async {
                              usuarioProvider.updateUser(
                                  user.cedula,
                                  txtName.text,
                                  user.lastName_1,
                                  user.lastName_2,
                                  txtEmail.text,
                                  user.password);
                              Navigator.pushReplacementNamed(context, 'login');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              child: const Text(
                                'Actualizar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
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
          Icons.person,
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
