import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const D20Roller(),
    );
  }
}

class D20Roller extends StatefulWidget {
  const D20Roller({super.key}); 

  @override
  _D20RollerState createState() => _D20RollerState(); 
}

class _D20RollerState extends State<D20Roller> {
  int resultado = 0; // Última tirada
  List<int> historial = []; // Historial de tiradas

  void tirarDado() {
    setState(() {
      resultado = Random().nextInt(20) + 1; // Número entre 1 y 20
      historial.insert(0, resultado); // Añadir la tirada al inicio de la lista
    });

    String mensaje = resultado == 20
        ? "🔥 CRÍTICO! 🔥"
        : resultado == 1
            ? "💀 PIFIA! 💀"
            : "🎲 Sacaste un $resultado.";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎲 Rol de D20", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: const Color(0xFFFFDAB9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("d20.png", width: 200),
            const SizedBox(height: 20),
            Text(
              resultado == 0 ? "Presiona para rolear" : "🎲 $resultado 🎲",
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            customButton("Tirar D20", Colors.brown, tirarDado),
            const SizedBox(height: 20),
            customButton("Historial", Colors.brown, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistorialScreen(historial: historial)),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget customButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}

// Segunda pantalla con historial de tiradas
class HistorialScreen extends StatelessWidget {
  final List<int> historial;

  const HistorialScreen({super.key, required this.historial});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de tiradas", style: TextStyle(fontSize: 20, color: Colors.white)), 
        backgroundColor: Colors.brown,
      ),
      backgroundColor: const Color(0xFFFFDAB9),
      body: historial.isEmpty
          ? const Center(
              child: Text(
                "Aún no has tirado el dado.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: historial.length,
              itemBuilder: (context, index) {
                return Card(
                  color: historial[index] == 20
                      ? Colors.green[300] // Crítico
                      : historial[index] == 1
                          ? Colors.red[300] // Pifia
                          : Colors.white,
                  child: ListTile(
                    title: Text(
                      "Tirada ${index + 1}: 🎲 ${historial[index]}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Volver", style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
      ),
    );
  }
}
