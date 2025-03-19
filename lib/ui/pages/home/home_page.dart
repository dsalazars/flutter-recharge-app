import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puntored/ui/pages/home/widgets/home_button.dart';
import 'package:puntored/ui/pages/recharge/recharge/providers/purchase_provider/purchase_provider.dart';
import 'package:puntored/ui/pages/recharge/recharge/providers/purchase_provider/purchase_state.dart';
import 'package:puntored/ui/widgets/exit_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _handleLogout(BuildContext context) {
    Navigator.pushReplacementNamed(context, "login");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseState = ref.watch(purchaseProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Inicio",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        centerTitle: true,
        actions: [
          LogoutButton(onLogout: () => _handleLogout(context)), // Botón de logout
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  purchaseState is PurchaseSuccess &&
                          purchaseState.recharges.isNotEmpty
                      ? ListView.builder(
                        itemCount: purchaseState.recharges.length,
                        itemBuilder: (context, index) {
                          final recharge = purchaseState.recharges[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_android,
                                        color: Colors.pink,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Número: ${recharge.number}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Valor: \$${recharge.amount}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    recharge.status,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      : const Center(
                        child: Text("No hay recargas disponibles."),
                      ),
            ),
            HomeButton(
              icon: Icons.phone_android,
              label: "Recargar Ahora",
              route: "/recargas",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
