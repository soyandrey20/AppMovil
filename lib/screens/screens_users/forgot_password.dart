import 'package:empezar/importaciones/imports.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var txtCedula = TextEditingController();

  @override
  void dispose() {
    txtCedula.dispose();
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
                Navigator.pushReplacementNamed(context, 'login');
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
                Text('Recuperar contraseña',
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
                            hintText: '########',
                            labelText: '# Cédula',
                            icon: const Icon(Icons.assignment_ind_outlined),
                          ),
                          validator: (value) {
                            String pattern = r'^[0-9]{10}$';
                            RegExp regExp = RegExp(pattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : '# Cédula no valido';
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledColor: Colors.grey,
                          color: Colors.deepPurple,
                          onPressed: () {
                            restorePassword(
                                txtCedula, usuarioProvider, context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: const Text('Confirmar ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ],
                    ))
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
