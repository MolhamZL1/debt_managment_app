import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../cubits/verfy email/verfy_email_cubit.dart';
import 'widgets/verf_code_view_body.dart';

class VerfCodeView extends StatelessWidget {
  const VerfCodeView({super.key, required this.email});
  static const routename = "vrfCode";
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerfyEmailCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: const Text(' كود التحقق')),
        body: VerfCodeViewBody(email: email),
      ),
    );
  }
}
