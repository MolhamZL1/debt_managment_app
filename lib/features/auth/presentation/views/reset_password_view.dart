import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../cubits/reset password/reset_password_cubit.dart';
import 'widgets/ResetPasswordViewBody.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});
  static const routename = "reset_password";
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: Text("تعيين كلمة مرور جديدة")),
        body: ResetPasswordViewBody(email: email),
      ),
    );
  }
}
