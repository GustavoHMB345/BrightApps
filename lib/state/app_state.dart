import 'package:flutter/material.dart';

// Classe que gerencia o estado do aplicativo
class AppState extends ChangeNotifier {
  // Variável privada que armazena o status do usuário
  String _userStatus = 'Offline';

  // Getter que permite acessar o status do usuário
  String get userStatus => _userStatus;

  // Método que atualiza o status do usuário
  void updateUserStatus(String status) {
    _userStatus = status; // Atualiza o status
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
  }
}
