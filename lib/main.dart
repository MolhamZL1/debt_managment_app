import 'package:debt_managment_app/core/functions/on_generate_route.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DebtManagmentApp());
}

class DebtManagmentApp extends StatelessWidget {
  const DebtManagmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      initialRoute: SignInView.routename,
      home: SignInView(),
    );
  }
}
