
import 'package:flutter/material.dart';
import 'package:puntored/ui/pages/authentication/login/login_page.dart';
import 'package:puntored/ui/pages/home/home_page.dart';
import 'package:puntored/utils/constants.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.home: (_) => const HomePage(),
  Routes.login: (_) => const LoginPage(),
  // Routes.login: (_) => const LoginPage(),
};
