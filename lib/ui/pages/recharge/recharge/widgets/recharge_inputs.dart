import 'package:flutter/material.dart';
import '../../../../../utils/validators/validartors.dart';

class RechargeInputs extends StatelessWidget {
  final TextEditingController cellphoneController;
  final TextEditingController valueController;

  const RechargeInputs({
    super.key,
    required this.cellphoneController,
    required this.valueController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: cellphoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: 'Número de celular'),
          validator: Validators.validatePhoneNumber,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: valueController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Valor a recargar'),
          validator: Validators.validateTransactionAmount,
        ),
      ],
    );
  }
}