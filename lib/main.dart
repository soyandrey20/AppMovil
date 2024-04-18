import 'package:empezar/providers/usuario_provider.dart';
import 'package:empezar/screens/screens_users/forgot_password.dart';
import 'package:empezar/screens/screens_users/home_screen.dart';
import 'package:empezar/screens/screens_admin/home_screen_admin.dart';
import 'package:empezar/screens/screens_admin/information_screen_admin.dart';
import 'package:empezar/screens/screens_users/login_screen.dart';
import 'package:empezar/screens/screens_admin/login_screen_admin.dart';
import 'package:empezar/screens/screens_users/register_screen.dart';
import 'package:empezar/screens/screens_users/restore_password.dart';
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
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
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
          'login_admin': (_) => const LoginScreenAdmin(),
          'home_admin': (_) => const HomeScreenAdmin(),
          'information_admin': (_) => const InformationScreenAdmin(),
        },
        initialRoute: 'wellcome',
      ),
    );
  }
}
