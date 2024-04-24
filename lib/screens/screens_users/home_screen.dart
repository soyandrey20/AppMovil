import 'package:flutter/material.dart';

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
              title: const Text('Tipo de sensor'),
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              title: const Text('Sensores'),
              onTap: () {
                Navigator.pushNamed(context, 'sensor');
              },
            ),
            ListTile(
              title: const Text('Parámetros'),
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
            ),
            ListTile(
              title: const Text('Tipo de parámetro'),
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
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
                Container(
                  child: const Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [],
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
