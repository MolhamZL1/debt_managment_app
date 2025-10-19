import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/features/auth/presentation/views/verf_code_view.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/clientes/presentation/views/client_detelies_view.dart';
import '../../features/main/presntation/views/main_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInView.routename:
      return MaterialPageRoute(builder: (_) => const SignInView());
    case SignUpView.routename:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case VerfCodeView.routename:
      return MaterialPageRoute(builder: (_) => const VerfCodeView());
    case MainView.routename:
      return MaterialPageRoute(builder: (_) => const MainView());
    case ClientDeteliesView.routename:
      return MaterialPageRoute(
        builder: (_) {
          final data = settings.arguments as Map<String, dynamic>;
          final id = data["id"];
          final name = data["name"];
          return ClientDeteliesView(clinetId: id as int, name: name as String);
        },
      );
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
