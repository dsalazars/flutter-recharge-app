import 'package:flutter/material.dart';

class LoginInputs extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginInputs({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginInputs> createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  bool _obscurePassword = true; // Estado para controlar la visibilidad

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo de usuario
        TextField(
          controller: widget.emailController,
          decoration: const InputDecoration(
            labelText: "Usuario",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 16),

        // Campo de contraseña con botón de ver/ocultar
        TextField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "Contraseña",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
