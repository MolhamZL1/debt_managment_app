import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../cubits/check code reset password/check_code_reset_password_cubit.dart';
import 'widgets/CheckCodeResetPasswordViewBody.dart';

class CheckCodeResetPasswordView extends StatelessWidget {
  const CheckCodeResetPasswordView({super.key, required this.email});
  static const routename = "check_code_reset_password";
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckCodeResetPasswordCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: const Text(' كود التحقق')),
        body: CheckCodeResetPasswordViewBody(email: email),
      ),
    );
  }
}
