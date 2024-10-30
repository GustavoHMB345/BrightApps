import 'package:centralizador/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:centralizador/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/fundo_papel_amassado.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.4,
                  child: Image.asset(
                    'assets/images/Marca_Bright_bee.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth * 0.8,  
                    ),
                    child: FlutterLogin(
                      theme: LoginTheme(
                        pageColorLight: Colors.transparent,
                        pageColorDark: Colors.transparent,
                      ),
                      onLogin: (data) => _authUser(data, context),
                      onSignup: _signupUser,
                      onSubmitAnimationCompleted: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                      },
                      onRecoverPassword: (name) => _recoverPassword(name, context),
                    ),
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
