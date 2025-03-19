import 'package:flutter/material.dart';

class RechargeButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RechargeButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: onPressed,
            child: const Text('Realizar Recarga'),
          );
  }
}