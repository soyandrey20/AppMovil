import 'package:empezar/providers/usuario_provider.dart';
import 'package:empezar/screens/forgot_password.dart';
import 'package:empezar/screens/home_screen.dart';
import 'package:empezar/screens/login_screen.dart';
import 'package:empezar/screens/register_screen.dart';
import 'package:empezar/screens/restore_password.dart';
import 'package:empezar/screens/wellcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usuario_provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          'login': (_) => const LoginScreen(),
          'home': (_) => const HomeScreen(),
          'forgot_password': (_) => const ForgotPasswordScreen(),
          'restore_password': (_) => const RestoretPasswordScreen(),
          'register': (_) => const RegisterScreen(),
          'wellcome': (_) => const WellcomeScreen(),
        },
        initialRoute: 'wellcome',
      ),
    );
  }
}
