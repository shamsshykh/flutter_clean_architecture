// lib/core/navigation/navigation_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/navigation/routes.dart';

class NavigationService {

  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;

  final GlobalKey<NavigatorState> _navigatorKey = Routes.navigatorKey;

  /// Push a named route onto the navigator.
  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  /// Replace current route with named route.
  Future<dynamic>? replaceWith(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pop the top-most route.
  void goBack<T extends Object?>([T? result]) {
    return _navigatorKey.currentState?.pop(result);
  }

  /// Push and remove all previous routes.
  Future<dynamic>? navigateAndRemoveUntil(String routeName, {Object? arguments}) {
    return _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
          (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}