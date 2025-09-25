import 'package:debt_managment_app/features/auth/presentation/views/widgets/verf_code_view_body.dart';
import 'package:flutter/material.dart';

class VerfCodeView extends StatelessWidget {
  const VerfCodeView({super.key});
  static const routename = "vrfCode";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' كود التحقق')),
      body: VerfCodeViewBody(),
    );
  }
}
