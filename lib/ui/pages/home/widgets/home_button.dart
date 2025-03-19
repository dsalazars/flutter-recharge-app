import 'package:flutter/material.dart';
import 'package:puntored/utils/constants.dart';
import 'package:puntored/utils/utils.dart';

class HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const HomeButton({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, Routes.recargas);
      },
      icon: Icon(icon, size: 24, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Menos redondeado
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
