import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/proveedores_recarga_entity.dart';
import '../../../../domain/entities/purchase_request_entity.dart';
import '../../../../utils/validators/validartors.dart';
import 'providers/proveedores_provider/proveedor_provider.dart';
import 'providers/proveedores_provider/proveedores_state.dart';
import 'providers/purchase_provider/purchase_provider.dart';
import 'providers/purchase_provider/purchase_state.dart';


class RechargePage extends ConsumerStatefulWidget {
  const RechargePage({super.key});

  @override
  ConsumerState<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends ConsumerState<RechargePage> {
  final _formKey = GlobalKey<FormState>();
  final _cellphoneController = TextEditingController();
  final _valueController = TextEditingController();
  ProveedorRecargaEntity? _selectedProveedor;

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
              if (proveedoresState is ProveedoresLoading)
                const CircularProgressIndicator()
              else if (proveedoresState is ProveedoresError)
                Text('Error: ${proveedoresState.message}')
              else if (proveedoresState is ProveedoresLoaded)
                DropdownButtonFormField<ProveedorRecargaEntity>(
                  value: _selectedProveedor,
                  items: proveedoresState.proveedores
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.nombre ?? 'Sin nombre'),
                        ),
                      )
                      .toList(),
                  hint: const Text('Selecciona un proveedor'),
                  onChanged: (value) {
                    setState(() {
                      _selectedProveedor = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Debes seleccionar un proveedor';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cellphoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de celular',
                ),
                validator: Validators.validatePhoneNumber,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor a recargar',
                ),
                validator: Validators.validateTransactionAmount,
              ),
              const SizedBox(height: 24),
              purchaseState is PurchaseLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _selectedProveedor != null) {
                          final request = PurchaseRequestEntity(
                            cellPhone: _cellphoneController.text.trim(),
                            value: _valueController.text.trim(),
                            supplierId: _selectedProveedor!.id ?? '',
                          );
                          ref
                              .read(purchaseProvider.notifier)
                              .realizarCompra(request);
                        } else {
                          _showErrorMessage(context,
                              'Por favor completa todos los campos correctamente.');
                        }
                      },
                      child: const Text('Realizar Recarga'),
                    ),
              const SizedBox(height: 20),
              if (purchaseState is PurchaseSuccess)
                Text(
                  purchaseState.message,
                  style: const TextStyle(color: Colors.green),
                ),
              if (purchaseState is PurchaseError)
                Text(
                  purchaseState.message,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
