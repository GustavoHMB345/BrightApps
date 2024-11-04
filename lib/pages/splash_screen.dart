import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
    
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 194, 14),
      body: Stack(
        children: [
          // Hexágono superior direito
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(200 * _animation.value, -200 * _animation.value), // Move para o canto superior direito
                child: Align(
                  alignment: Alignment.center, // Origem do centro
                  child: Image.asset(
                    'assets/images/brown_hex.png',
                    width: MediaQuery.of(context).size.width * 1.2,
                    height: MediaQuery.of(context).size.width * 1.2,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          // Hexágono superior esquerdo
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-200 * _animation.value, -200 * _animation.value), // Move para o canto superior esquerdo
                child: Align(
                  alignment: Alignment.center, // Origem do centro
                  child: Image.asset(
                    'assets/images/brown_hex.png',
                    width: MediaQuery.of(context).size.width * 1.2,
                    height: MediaQuery.of(context).size.width * 1.2,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          // Hexágono inferior direito
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(200 * _animation.value, 200 * _animation.value), // Move para o canto inferior direito
                child: Align(
                  alignment: Alignment.center, // Origem do centro
                  child: Image.asset(
                    'assets/images/brown_hex.png',
                    width: MediaQuery.of(context).size.width * 1.2,
                    height: MediaQuery.of(context).size.width * 1.2,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
