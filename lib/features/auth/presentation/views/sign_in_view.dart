import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:debt_managment_app/features/auth/presentation/cubits/sign%20in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/utils/show_err_dialog.dart';
import '../../../main/presntation/views/main_view.dart';
import 'widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});
  static const routename = "signin";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt.get<AuthRepo>()),
      child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            showerrorDialog(
              context: context,
              title: "فشل تسجيل الدخول",
              description: state.errMessage,
            );
          }
          if (state is SignInSuccess) {
            Navigator.pushReplacementNamed(context, MainView.routename);
          }
        },
        child: const Scaffold(body: SignInViewBody()),
      ),
    );
  }
}
