import 'package:flutter/cupertino.dart';

class Routes {

  Routes._internal();

  static final Routes _instance = Routes._internal();

  factory Routes() => _instance;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String details = '/details';
}