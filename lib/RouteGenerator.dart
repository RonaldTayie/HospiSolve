import 'package:flutter/material.dart';
import 'package:hospisolve/views/LandingView.dart';
import 'package:hospisolve/views/RegisterView.dart';
import 'package:hospisolve/views/LoginView.dart';
import 'package:hospisolve/views/pages/HomeView.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/landing':
        return MaterialPageRoute(builder: (_)=>const LandingView());
      case '/register':
        return MaterialPageRoute(builder: (_)=>const RegisterView());
      case '/login':
        return MaterialPageRoute(builder: (_)=>const LoginView());
      // case "/notification":
      //   return MaterialPageRoute(builder: (_)=> Notifications(coupon: args));
      default:
        return MaterialPageRoute(builder: (_) => const LandingView());
    }
  }
}