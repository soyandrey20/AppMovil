import 'package:empezar/importaciones/imports.dart';

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
          'register': (_) => const RegisterScreen(),
          'wellcome': (_) => const WellcomeScreen(),
          'analisis': (_) => const AnalisisScreen(),
          'info_user': (_) => const InfoUser(),
        },
        initialRoute: 'wellcome',
      ),
    );
  }
}
