import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  bool _isLoading = false;
  bool _isCompleted = false; // when count reaches 10

  int get count => _count;
  bool get isLoading => _isLoading;
  bool get isCompleted => _isCompleted;

  void increment() {
    try {
      _isLoading = true;
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 300), () {
        _count++;
        _isLoading = false;
        if (_count == 10) {
          _isCompleted = true;
        }
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // clear state
  void reset() {
    _count = 0;
    notifyListeners();
  }
}
