import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login(String username, String password) {
    if (username == 'adm' && password == '1212') {
      _isAuthenticated = true;
      notifyListeners(); // Notifica a mudança de estado para os ouvintes (widgets)
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
