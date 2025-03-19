import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/config/themes/defaul_theme.dart';
import 'package:puntored/dependecy_injection/injection.dart' as di;
import 'package:puntored/ui/pages/authentication/login/login_page.dart';
import 'package:puntored/ui/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); 

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight, 
  ]);

  runApp(
    const ProviderScope( 
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
