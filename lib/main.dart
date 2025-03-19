import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/config/themes/defaul_theme.dart';
import 'package:puntored/dependecy_injection/injection.dart' as di;
import 'package:puntored/ui/pages/authentication/login/login_page.dart';
import 'package:puntored/ui/routes.dart'; // Importa este paquete

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Asegura la inicialización de dependencias antes de ejecutar la app.

  await SystemChrome.setPreferredOrientations([
    // Configura las orientaciones preferidas
    DeviceOrientation.portraitUp, // Retrato normal
    DeviceOrientation.landscapeLeft, // Paisaje a la izquierda
    DeviceOrientation.landscapeRight, // Paisaje a la derecha
  ]);

  runApp(
    const ProviderScope( // Envuelve la app en ProviderScope para Riverpod
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuntoRed',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      theme: defaultTheme(),
      home: const LoginPage(),
    );
  }
  
}
