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
          'login_admin': (_) => const LoginScreenAdmin(),
          'home_admin': (_) => const HomeScreenAdmin(),
          'information_admin': (_) => const InformationScreenAdmin(),
          'sensor': (_) => const SensorScreen(),
          'tipo_sensor': (_) => const TipoSensorScreen(),
          'parametros': (_) => const ParametroScreen(),
          'tipo_parametro': (_) => const TipoParametroScreen(),
          'analisis': (_) => const AnalisisScreen(),
          'eliminar_tss': (_) => const TipoSensorEliminarScreen(),
          'eliminar_tpp': (_) => const TipoParametroEliminarScreen(),
          'para_sensor': (_) => const ParaSensorScreen(),
          'info_user': (_) => const InfoUser(),
        },
        initialRoute: 'wellcome',
      ),
    );
  }
}
