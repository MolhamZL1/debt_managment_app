import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInView.routename:
      return MaterialPageRoute(builder: (_) => const SignInView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
