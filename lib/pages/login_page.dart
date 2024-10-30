import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:centralizador/state/app_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data, BuildContext context) async {
    final appState = Provider.of<AppState>(context, listen: false);
    return Future.delayed(loginTime).then((_) {
      if (!appState.validateUser(data.name, data.password)) {
        return 'Usuário não existe ou a senha está incorreta';
      }
      appState.updateStatus('online');
      return null;
    });
  }

  Future<String> _recoverPassword(String name, BuildContext context) async {
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/fundo_papel_amassado.png',
          fit: BoxFit.cover,
        ),
        Center(
          child: FlutterLogin(
            logo: 'assets/images/Marca_Bright_bee.png',
            onLogin: (data) => _authUser(data, context),
            onSignup: (data) {
              // Redireciona para a HomeScreen sem fazer a validação de signup
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
              return null; // Para evitar mensagens de erro
            },
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            onRecoverPassword: (name) => _recoverPassword(name, context),
            theme: LoginTheme(
              pageColorLight: Colors.transparent,
              pageColorDark: Colors.transparent,
            ),
            messages: LoginMessages(
              userHint: 'Usuário',
              passwordHint: 'Senha',
              confirmPasswordHint: 'Confirmação',
              loginButton: 'LOG IN',
              signupButton: 'Entrar como convidado',
              forgotPasswordButton: '',
              recoverPasswordButton: 'AJUDA',
              goBackButton: 'VOLTAR',
              confirmPasswordError: 'Não coincide!',
              recoverPasswordDescription: '',
              recoverPasswordSuccess: 'Senha recuperada com sucesso',
            ),
            hideForgotPasswordButton: true,
          ),
        ),
      ],
    );
  }
}
