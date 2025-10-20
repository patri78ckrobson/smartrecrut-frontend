import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _userRole = '';
  String _token = '';
  String _userId = '';

  bool get isAuthenticated => _isAuthenticated;
  String get userRole => _userRole;
  String get token => _token;
  String get userId => _userId;

  Future<bool> login(String email, String password) async {
    // Simulation d'une authentification réussie
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _userRole = email.contains('admin') ? 'admin' : 
                 email.contains('rh') ? 'rh' : 
                 email.contains('manager') ? 'manager' : 'candidat';
      _token = 'fake_token_${DateTime.now().millisecondsSinceEpoch}';
      _userId = '1';
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _userRole = '';
    _token = '';
    _userId = '';
    notifyListeners();
  }
}