import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/sign_up_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInView.routename:
      return MaterialPageRoute(builder: (_) => const SignInView());
      case SignUpView.routename:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
