import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_provider.dart';
import 'package:puntored/ui/routes.dart';
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
        // Redireccionar al Home cuando el token no es nulo
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Usuario',
            labelStyle: const TextStyle(color: Colors.pinkAccent),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pinkAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle: const TextStyle(color: Colors.pinkAccent),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pinkAccent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 24),
        loginState.isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(loginProvider.notifier).login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                    },
                    child: const Text("Limpiar campos", style: TextStyle(color: Colors.pinkAccent)),
                  ),
                ],
              ),
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