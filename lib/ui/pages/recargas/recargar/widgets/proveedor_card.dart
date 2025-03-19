import 'package:flutter/material.dart';

import '../../../../../domain/entities/proveedores_recarga_entity.dart';


class ProveedorCard extends StatelessWidget {
  final ProveedorRecargaEntity proveedor;

  const ProveedorCard({super.key, required this.proveedor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.phone_android),
        title: Text(proveedor.nombre ?? 'Sin nombre'),
        subtitle: Text('ID: ${proveedor.id ?? ''}'),
        onTap: () {
          // Aquí puedes navegar o abrir un modal de recarga
        },
      ),
    );
  }
}
