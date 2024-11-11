import 'package:centralizador/pages/splash_screen.dart'; 
import 'package:centralizador/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

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
      home: SplashScreen(), // Começa com a tela de splash
    );
  }
}
