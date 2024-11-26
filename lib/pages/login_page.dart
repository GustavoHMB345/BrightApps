import 'package:brightapps/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:brightapps/state/app_state.dart';
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
  bool _isLoading = false; // Adicionando o estado para o carregamento

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
    setState(() {
      _isLoading = true; // Inicia a animação de carregamento
    });
    
    final appState = Provider.of<AppState>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 2250));
    final isValid = appState.validateUser(_usernameController.text, _passwordController.text);

    if (!mounted) return;

    setState(() {
      _isLoading = false; // Finaliza a animação de carregamento
    });

    if (isValid) {
      appState.updateStatus('online');
      _navigateToHomeScreen();
    } else {
      _showMessage('Usuário não existe ou a senha está incorreta');
    }
  }

  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Começando à direita
          const end = Offset.zero; // Terminando na posição original
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
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
    // Pegando as dimensões da tela
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/fundo_papel_amassado.jpg', fit: BoxFit.cover),
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: screenHeight * 0.6, // Ajustando a altura para ser proporcional à tela
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Usando Expanded para fazer o layout se adaptar melhor
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/fundo_correto.png',
                          width: double.infinity,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(_usernameController, 'Usuário'),
                      const SizedBox(height: 20),
                      _buildTextField(_passwordController, 'Senha', obscureText: true),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: _buildButton('Entrar', _authUser),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _navigateToHomeScreen,
                          child: const Text('Entrar como convidado', style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                      if (_isLoading) // Exibe o carregamento quando necessário
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 194, 14)),
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
