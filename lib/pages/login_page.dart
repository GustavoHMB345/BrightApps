import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

const users = {
  'adm@gmail.com': '1212',
  'VASCO': '0000',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo
          Image.asset(
            'assets/images/fundo_papel_amassado.png',
            fit: BoxFit.cover,
          ),
          // FlutterLogin widget sobreposto na imagem
          FlutterLogin(
            logo: const AssetImage('assets/images/Marca_Bright_bee.png'),
             theme: LoginTheme(
              // Defina as cores das páginas como transparentes para não sobrepor a imagem
              pageColorLight: Colors.transparent,
              pageColorDark: Colors.transparent,
              ),
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            onRecoverPassword: _recoverPassword,
          ),
        ],
      ),
    );
  }
}
