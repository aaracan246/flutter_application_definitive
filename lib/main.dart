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
      home: D20Roller(),
    );
  }
}

class D20Roller extends StatefulWidget {
  const D20Roller({super.key});

  @override
  _D20RollerState createState() => _D20RollerState();
}

class _D20RollerState extends State<D20Roller> {
  int resultado = 0; // Resultado del dado

  void tirarDado() {
    setState(() {
      resultado = Random().nextInt(20) + 1; // Número entre 1 y 20 (extensible a cualquier dado)
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
        title: const Text("🎲 Rol de D20", style: TextStyle(fontSize: 20, color: Colors.white)), // No existen emojis de D20 :(
        backgroundColor: Colors.brown,
      ),
      backgroundColor: const Color(0xFFFFDAB9),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.casino, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              resultado == 0 ? "Presiona para rolear" : "🎲 $resultado 🎲",
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: tirarDado,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text("Tirar D20", style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
