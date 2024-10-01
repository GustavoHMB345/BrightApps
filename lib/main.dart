import 'package:centralizador/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa a classe AppState
import 'pages/home_screen.dart'; // Importa a tela HomeScreen

void main() {
  runApp(
    // Envolve o aplicativo em um ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => AppState(), // Cria uma instância de AppState
      child: const MyApp(), // Passa o MyApp como filho
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      home: HomeScreen(), // Define HomeScreen como a tela inicial
    );
  }
}
