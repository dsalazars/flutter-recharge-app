import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/ui/pages/authentication/login/providers/login_provider.dart';

class LoginButton extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return loginState.isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(loginProvider.notifier).login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  emailController.clear();
                  passwordController.clear();
                },
                child: const Text(
                  "Limpiar campos",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          );
  }
}