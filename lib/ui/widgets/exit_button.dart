import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  void _exitApp() {
    SystemNavigator.pop(); // Cierra la app
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _exitApp,
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
      label: const Text("Salir", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}