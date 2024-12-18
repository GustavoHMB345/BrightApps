import 'package:centralizador/pages/login_page.dart'; // Importe a LoginScreen
import 'package:centralizador/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(), // Configura o Provider para gerenciar o estado
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Começa com a tela de login
    );
  }
}
