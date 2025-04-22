import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/navigation/routes.dart';

class AppLoading {
  AppLoading._(); // Private constructor for singleton

  static final AppLoading _instance = AppLoading._(); // Singleton instance

  factory AppLoading() {
    return _instance;
  }

  static final GlobalKey<NavigatorState> navigatorKey = Routes.navigatorKey;

  static bool _isDialogOpen = false;

  static void show() {
    if (_isDialogOpen) return;

    _isDialogOpen = true;

    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      debugPrint('Navigator context is null, unable to show loading dialog.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.blueAccent,
              size: 60,
            ),
          ),
        );
      },
    ).then((_) {
      _isDialogOpen = false;
    });
  }

  static void hide() {
    if (_isDialogOpen) {
      navigatorKey.currentState?.pop();
      _isDialogOpen = false;
    }
  }
}
