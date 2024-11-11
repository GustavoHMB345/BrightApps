import 'package:centralizador/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late double hexWidth;
  late double hexHeight;
  late AnimationController _controller;
  late Animation<double> _animation;

  double hex1X = 0.1;
  double hex1Y = 1.0;
  double hex2X = 0.9;
  double hex2Y = 0.001;
  late double transparentHexWidth;
  late double transparentHexHeight;

  bool isBlocked = false; // Inicialmente bloqueado

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !isBlocked) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  void unblockNavigation() {
    setState(() {
      isBlocked = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Definir tamanho do hexágono animado
    hexWidth = MediaQuery.of(context).size.width * 0.8;
    hexHeight = hexWidth * 1.5;

    // Para a borda_hex.png - Redefinindo para 60% da tela
    transparentHexWidth = MediaQuery.of(context).size.width * 0.9; // 60% da largura da tela
    transparentHexHeight = MediaQuery.of(context).size.height * 0.9; // 60% da altura da tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mudança no background para usar imagem local
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_amarelo.png'), // Imagem local para o fundo
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final Offset hex1Position = Offset(
              MediaQuery.of(context).size.width * (hex1X + _animation.value) - hexWidth / 2,
              MediaQuery.of(context).size.height * hex1Y - hexHeight / 2,
            );

            final Offset hex2Position = Offset(
              MediaQuery.of(context).size.width * (hex2X - _animation.value) - hexWidth / 2,
              MediaQuery.of(context).size.height * hex2Y - hexHeight / 2,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                // Hexágono animado com a imagem brown_hex.png
                Positioned(
                  left: hex1Position.dx,
                  top: hex1Position.dy,
                  child: buildHexagon(1, 'assets/images/brown_hex.png', boxFit: BoxFit.cover),
                ),
                Positioned(
                  left: hex2Position.dx,
                  top: hex2Position.dy,
                  child: buildHexagon(2, 'assets/images/brown_hex.png', boxFit: BoxFit.cover),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5,
                  child: const Text(
                    'Bright Links',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildHexagon(int number, String imagePath, {double? width, double? height, BoxFit? boxFit}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          imagePath,
          width: width ?? hexWidth,  // Usa `width` se fornecido, senão `hexWidth`
          height: height ?? hexHeight,  // Usa `height` se fornecido, senão `hexHeight`
          fit: boxFit ?? BoxFit.none,  // Usa `boxFit` se fornecido, senão `BoxFit.none`
        ),
      ],
    );
  }
}
