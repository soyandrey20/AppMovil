import 'package:empezar/importaciones/imports.dart';

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
