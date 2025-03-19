import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/ui/pages/recharge/recharge/providers/purchase_provider/purchase_state.dart';
import 'package:puntored/ui/pages/recharge/recharge/widgets/provider_dropdown.dart';
import 'package:puntored/ui/pages/recharge/recharge/widgets/recharge_button.dart';
import 'package:puntored/ui/pages/recharge/recharge/widgets/recharge_inputs.dart';
import '../../../../domain/entities/purchase_request_entity.dart';
import 'providers/proveedores_provider/proveedor_provider.dart';
import 'providers/purchase_provider/purchase_provider.dart';


class RechargePage extends ConsumerStatefulWidget {
  const RechargePage({super.key});

  @override
  ConsumerState<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends ConsumerState<RechargePage> {
  final _formKey = GlobalKey<FormState>();
  final _cellphoneController = TextEditingController();
  final _valueController = TextEditingController();
  String? _selectedProveedorId;

  @override
  void dispose() {
    _cellphoneController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _onProveedorSelected(String? id) {
    setState(() {
      _selectedProveedorId = id;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedProveedorId != null) {
      final request = PurchaseRequestEntity(
        cellPhone: _cellphoneController.text.trim(),
        value: _valueController.text.trim(),
        supplierId: _selectedProveedorId!,
      );
      ref.read(purchaseProvider.notifier).realizarCompra(request);
    } else {
      _showErrorMessage(context, 'Por favor completa todos los campos correctamente.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final proveedoresState = ref.watch(proveedoresProvider);
    final purchaseState = ref.watch(purchaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recargas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProviderDropdown(
                proveedoresState: proveedoresState,
                onProveedorSelected: _onProveedorSelected,
              ),
              const SizedBox(height: 16),
              RechargeInputs(
                cellphoneController: _cellphoneController,
                valueController: _valueController,
              ),
              const SizedBox(height: 24),
              RechargeButton(
                isLoading: purchaseState is PurchaseLoading,
                onPressed: _submitForm,
              ),
              const SizedBox(height: 20),
              if (purchaseState is PurchaseSuccess)
                Text(purchaseState.message, style: const TextStyle(color: Colors.green)),
              if (purchaseState is PurchaseError)
                Text(purchaseState.message, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
