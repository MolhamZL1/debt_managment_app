import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repo/auth_repo.dart';
import '../cubits/forget password/forget_password_cubit.dart';
import 'widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static const routename = "forget_password";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('استعادة كلمة المرور')),
        body: ForgetPasswordViewBody(),
      ),
    );
  }
}
