import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/navigation/routes.dart';
import 'package:flutter_clean_architecture/main.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return routeBuilder(const ComplexUserScreen());
      case Routes.login:
        return routeBuilder(const ComplexUserScreen());
      case Routes.home:
        return routeBuilder(const ComplexUserScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => UndefinedRoutePage(name: settings.name),
        );
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class UndefinedRoutePage extends StatelessWidget {
  final String? name;

  const UndefinedRoutePage({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Route for "$name" is not defined')),
    );
  }
}
