import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'recargar/providers/proveedores_provider/proveedor_provider.dart';
import 'recargar/providers/proveedores_provider/proveedores_state.dart';

class RecargarPage extends ConsumerWidget {
  const RecargarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(proveedoresProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recargas')),
      body: Builder(
        builder: (context) {
          if (state is ProveedoresLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProveedoresError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProveedoresLoaded) {
            return ListView.builder(
              itemCount: state.proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = state.proveedores[index];
                return ListTile(
                  title: Text(proveedor.nombre ?? ''),
                  subtitle: Text(proveedor.id ?? ''),
                );
              },
            );
          } else {
            return const Center(child: Text('Estado desconocido'));
          }
        },
      ),
    );
  }
}
