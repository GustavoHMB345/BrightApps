import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Aqui você pode adicionar a lógica de autenticação
    // Exemplo: Validar usuário e senha
    if (username == 'adm' && password == '1212') {
      // Se o login for bem-sucedido, navegue para a HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Falha no login
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Usuário ou senha inválidos!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
