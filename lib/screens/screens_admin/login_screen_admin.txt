import 'package:empezar/importaciones/imports.dart';

class LoginScreenAdmin extends StatefulWidget {
  const LoginScreenAdmin({super.key});

  @override
  State<LoginScreenAdmin> createState() => _LoginScreenAdminState();
}

class _LoginScreenAdminState extends State<LoginScreenAdmin> {
  var txtCedula = TextEditingController();
  var txtPassword = TextEditingController();

  @override
  void dispose() {
    txtCedula.dispose();
    txtPassword.dispose();
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
                Navigator.pushReplacementNamed(context, 'wellcome');
              },
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);

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
                Text('Login admin',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
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
                              : '# Cédula no válido';
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        controller: txtPassword,
                        decoration: InputDecorations.inputDecoration(
                          hintText: '*********',
                          labelText: 'Contraseña',
                          icon: const Icon(Icons.lock_outline),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurple,
                        onPressed: () {
                          loginAdmin(
                              usuarioProvider, txtCedula, txtPassword, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          child: const Text('Ingresar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void loginAdmin(
      UsuarioProvider usuarioProvider,
      TextEditingController txtCedula,
      TextEditingController txtPassword,
      BuildContext context) {
    var user = usuarioProvider.usuarios;

    var existingAcount = 1;
    var index = 0;

    for (index = 0; index < user.length; index++) {
      if (user[index].cedula == txtCedula.text &&
          user[index].password == txtPassword.text) {
        existingAcount = 0;
        break;
      } else {
        existingAcount = 1;
      }
    }

    if (existingAcount == 0 && user[index].permisos == 'Admin') {
      usuarioProvider.getUsers();
      Navigator.pushReplacementNamed(context, 'information_admin');
    } else if (existingAcount == 0 && user[index].permisos != 'Admin') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso denegado, intente de nuevo'),
        ),
      );
    } else if (existingAcount == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos incorrectos, intente de nuevo')));
    }
  }
}
