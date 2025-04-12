import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _token = '';
  String _error = '';

  bool get isAuthenticated => _isAuthenticated;
  String get token => _token;
  String get error => _error;

  Future<void> login(String email, String password) async {
    try {
      // TODO: Implement login
      _isAuthenticated = true;
      _token = 'dummy_token';
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    _token = '';
    notifyListeners();
  }
} 