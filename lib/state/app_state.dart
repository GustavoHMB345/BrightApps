import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String _status = 'offline'; // Status inicial do usuário
  String _onlineMessage = 'Você está offline'; // Mensagem de status

  String get status => _status; // Getter para o status
  String get onlineMessage => _onlineMessage; // Getter para a mensagem de status

  void updateStatus(String newStatus) {
    _status = newStatus; // Atualiza o status
    _updateOnlineMessage(); // Atualiza a mensagem de status
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  void _updateOnlineMessage() {
    if (_status == 'online') {
      _onlineMessage = 'Você está online';
    } else {
      _onlineMessage = 'Você está offline';
    }
  }

  // Lógica para gerenciamento de usuários e senhas
  final Map<String, String> users = const {
    'adm@gmail.com': '1212',
    'VASCO@gmail.com': '0000',
  };

  bool validateUser(String email, String password) {
    // Valida o usuário com o e-mail e a senha fornecidos
    return users.containsKey(email) && users[email] == password;
  }
}
