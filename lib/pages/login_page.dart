import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:centralizador/state/app_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data, BuildContext context) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    final appState = Provider.of<AppState>(context, listen: false);

    return Future.delayed(loginTime).then((_) {
      if (!appState.validateUser(data.name, data.password)) {
        return 'Usuário não existe ou a senha está incorreta';
      }

      appState.updateStatus('online');
      return null; // Retorna null para indicar sucesso no login
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null; // Retorna null para indicar sucesso no cadastro
    });
  }

  Future<String> _recoverPassword(String name, BuildContext context) async { // Adicionado 'context' como parâmetro
    debugPrint('Name: $name');
    final appState = Provider.of<AppState>(context, listen: false);
    return Future.delayed(loginTime).then((_) {
      if (!appState.users.containsKey(name)) { // Usando a referência correta
        return 'Usuário não existe';
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
            onLogin: (data) => _authUser(data, context), // Passa o contexto para o método de autenticação
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            onRecoverPassword: (name) => _recoverPassword(name, context), // Passa o contexto aqui também
          ),
        ],
      ),
    );
  }
}
