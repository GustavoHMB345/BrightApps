import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String _status = 'offline'; // Status inicial do usuário

  String get status => _status; // Getter para o status

  void updateStatus(String newStatus) {
    _status = newStatus; // Atualiza o status
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }
}
