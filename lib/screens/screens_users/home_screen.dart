import 'package:empezar/importaciones/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
        ],
      ),
      appBar: AppBar(
        title: const Text('Opciones'),
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
              margin: EdgeInsetsDirectional.all(8),
              child: Text('Opciones'),
            ),
            ListTile(
              title: const Text('Análisis'),
              onTap: () {
                Navigator.pushNamed(context, 'analisis');
              },
            ),
            ListTile(
              title: const Text('Parámetro sensor'),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 300), // Adjust padding as needed
                child: TextButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text(
                    'Ver perfil',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the user profile screen here
                    Navigator.pushNamed(
                        context, 'info_user'); // Replace with your route name
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
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
              color: Colors.white.withOpacity(0.0),
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
                Text(
                  ' Bienvenidos   ',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 30)
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ' Seleccione una opción',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 30)
                      .copyWith(color: Colors.white),
                ),
                const Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [],
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
