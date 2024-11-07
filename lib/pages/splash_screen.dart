import 'package:centralizador/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late double hexWidth; // Largura do hexágono
  late double hexHeight; // Altura do hexágono
  late AnimationController _controller;
  late Animation<double> _animation;

  double hex1X = 0.1; // Posição X inicial do hexágono 1
  double hex1Y = 1.0; // Posição Y inicial do hexágono 1
  double hex2X = 0.9; // Posição X inicial do hexágono 2
  double hex2Y = 0.001; // Posição Y inicial do hexágono 2

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

    // Adiciona um atraso para navegar para a página de login após a animação
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hexWidth = MediaQuery.of(context).size.width * 0.8;
    hexHeight = hexWidth * 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 194, 14),
      body: AnimatedBuilder(
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
              Positioned(
                left: hex1Position.dx,
                top: hex1Position.dy,
                child: buildHexagon(1),
              ),
              Positioned(
                left: hex2Position.dx,
                top: hex2Position.dy,
                child: buildHexagon(2),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                child: const Text(
                  'Bright Links',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu', // Usa a fonte Ubuntu Medium
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildHexagon(int number) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/brown_hex.png',
          width: hexWidth,
          height: hexHeight,
          fit: BoxFit.cover,
        ),
        Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
