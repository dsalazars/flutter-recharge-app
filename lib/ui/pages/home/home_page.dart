import 'package:flutter/material.dart';
import 'package:puntored/ui/pages/home/widgets/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: 
      SafeArea(
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: Text("Recarga $index"),
                        subtitle: Text("Valor: \$${index * 1000}"),
                      ),
                    ),
                  ),
                );
              },
            )),
            HomeButton(
              icon: Icons.phone_android,
              label: "Recargar Ahora",
              route: "/recargas",
            ),
          ],
        ),
      )
      /* Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  size: 80,
                  color: Colors.pink,
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "No hay recargas",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Hasta ahora no tienes registro de recargas en tu línea",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                HomeButton(
                  icon: Icons.phone_android,
                  label: "Recargar Ahora",
                  route: "/recargas",
                ),
              ],
            ),
          ),
        ),
      ), */
    );
  }
}