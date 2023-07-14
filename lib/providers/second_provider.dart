import 'package:flutter/material.dart';

class SecondProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void increment() {
    _count++;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
