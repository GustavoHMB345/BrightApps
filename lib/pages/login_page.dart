import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:centralizador/state/app_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  Future<void> _authUser() async {
    final appState = Provider.of<AppState>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 2250)); // Simula o tempo de resposta
    final isValid = appState.validateUser(_usernameController.text, _passwordController.text);

    if (!mounted) return; // Garante que o widget ainda esteja na árvore

    if (isValid) {
      appState.updateStatus('online');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      _showMessage('Usuário não existe ou a senha está incorreta');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/fundo_papel_amassado.png', fit: BoxFit.cover),
        Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: SingleChildScrollView(
              child: Container(
                width: 400, // Definindo uma largura fixa
                height: 400, // Definindo uma altura fixa
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/fundo_correto.png',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    _buildTextField(_usernameController, 'Usuário'),
                    const SizedBox(height: 20),
                    _buildTextField(_passwordController, 'Senha', obscureText: true),
                    const SizedBox(height: 20),
                    // Botão "Entrar" com largura igual ao campo de texto
                    SizedBox(
                      width: double.infinity, // Faz o botão ocupar toda a largura disponível
                      
                      child: _buildButton('Entrar', _authUser),
                    ),
                    const SizedBox(height: 20),
                    // Botão "Entrar como convidado" com largura igual ao campo de texto
                    SizedBox(
                      width: double.infinity, // Faz o botão ocupar toda a largura disponível
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        ),
                        child: const Text('Entrar como convidado', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        ),
    );
  }
}
