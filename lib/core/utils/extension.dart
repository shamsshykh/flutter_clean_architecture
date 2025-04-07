import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

extension Extension  on BuildContext {
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showToast(String message) {

  }
}
