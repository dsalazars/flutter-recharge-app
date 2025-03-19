import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_provider.dart';
import 'package:puntored/ui/pages/authentication/login/widgets/login_button.dart';
import 'package:puntored/ui/pages/authentication/login/widgets/login_inputs.dart';
import 'package:puntored/utils/constants.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController(text: "user0147");
  final _passwordController = TextEditingController(text: "#3Q34Sh0NlDS");

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      if (next.token != null) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Campos de usuario y contraseña
        LoginInputs(
          emailController: _emailController,
          passwordController: _passwordController,
        ),
        const SizedBox(height: 24),

        // Botón de iniciar sesión
        LoginButton(
          emailController: _emailController,
          passwordController: _passwordController,
        ),

        // Mensaje de error
        if (loginState.errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(
            loginState.errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ],
    );
  }
}