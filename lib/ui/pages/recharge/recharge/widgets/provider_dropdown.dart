import 'package:flutter/material.dart';
import 'package:puntored/domain/entities/proveedores_recarga_entity.dart';
import 'package:puntored/ui/pages/recharge/recharge/providers/proveedores_provider/proveedores_state.dart';

class ProviderDropdown extends StatelessWidget {
  final ProveedoresState proveedoresState;
  final Function(String?) onProveedorSelected;

  const ProviderDropdown({
    super.key,
    required this.proveedoresState,
    required this.onProveedorSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (proveedoresState is ProveedoresLoading) {
      return const CircularProgressIndicator();
    }

    if (proveedoresState is ProveedoresError) {
      final errorState = proveedoresState as ProveedoresError;
      return Text('Error: ${errorState.message}');
    }

    if (proveedoresState is ProveedoresLoaded) {
      final loadedState = proveedoresState as ProveedoresLoaded;

      return DropdownButtonFormField<ProveedorRecargaEntity>(
        items: loadedState.proveedores
            .map((p) => DropdownMenuItem(
                  value: p,
                  child: Text(p.nombre ?? 'Sin nombre'),
                ))
            .toList(),
        hint: const Text('Selecciona un proveedor'),
        onChanged: (value) => onProveedorSelected(value?.id),
        validator: (value) =>
            value == null ? 'Debes seleccionar un proveedor' : null,
      );
    }

    return const SizedBox();
  }
}