import 'dart:async';

import 'package:flutter/material.dart';

/// Método que ejecuta una función tras pasar un tiempo
/// sin que el usuario escriba
class Debouncer {
  Timer _timer;

  void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 50), callback);
  }

  void wait(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1500), callback);
  }
}
