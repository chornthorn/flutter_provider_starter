import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    // simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _isAuthenticated = false;
    _isLoading = false;
    notifyListeners();
  }

  // check if user is authenticated
  Future<void> checkAuth() async {
    // simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // check if user is authenticated
    // _isAuthenticated = false;

    notifyListeners();
  }
}
