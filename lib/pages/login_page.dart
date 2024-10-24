import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:centralizador/state/app_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 1250);

  Future<String?> _authUser(LoginData data, BuildContext context) async {
    debugPrint('Nome: ${data.name}, Senha: ${data.password}');
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
    debugPrint('Cadastrar: ${data.name}, Senha: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null; // Retorna null para indicar sucesso no cadastro
    });
  }

  Future<String> _esqueciasenha(String name, BuildContext context) async {
    debugPrint('Name: $name');
    final appState = Provider.of<AppState>(context, listen: false);
    return Future.delayed(loginTime).then((_) {
      if (!appState.users.containsKey(name)) {
        return 'Usuário não existe';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
          SizedBox(
            child: Column(
              children: [
                // Adicionar espaço no topo para centralizar o FlutterLogin
                const SizedBox(height: 10),
                
                // A logo está fora do FlutterLogin, permitindo ajustar a largura
                SizedBox(
                  width: screenWidth * 0.3, // 60% da largura da tela
                  child: Image.asset(
                    'assets/images/Marca_Bright_bee.png',
                    fit: BoxFit.contain,
                  ),
                ),
                
                // Widget FlutterLogin abaixo da logo
                Expanded(
                  child: FlutterLogin(
                    theme: LoginTheme(
                      pageColorLight: Colors.transparent,
                      pageColorDark: Colors.transparent,
                    ),
                    messages: LoginMessages(
                      userHint: 'Digite seu nome de usuário',
                      passwordHint: 'Digite sua senha',
                      loginButton: 'Entrar',
                      signupButton: 'Registrar-se',
                      recoverPasswordButton: 'Enviar',
                      forgotPasswordButton: 'Recuperar sua senha?',
                      recoverPasswordDescription:
                          'Por favor, insira seu email para que possamos enviar token de mudança de senha',
                      recoverCodePasswordDescription: 'Enviar',
                    ),
                    onLogin: (data) => _authUser(data, context),
                    onSignup: _signupUser,
                    onSubmitAnimationCompleted: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                    },
                    onRecoverPassword: (name) => _esqueciasenha(name, context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
