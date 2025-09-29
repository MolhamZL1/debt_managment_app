import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:debt_managment_app/features/auth/presentation/cubits/sign%20up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/show_err_dialog.dart';
import '../../../main/presntation/views/main_view.dart';
import 'widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routename = "signup";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt.get<AuthRepo>()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            showerrorDialog(
              context: context,
              title: "فشل إنشاء الحساب",
              description: state.errMessage,
            );
          }
          if (state is SignUpSuccess) {
            Navigator.pushReplacementNamed(context, MainView.routename);
          }
        },
        child: const Scaffold(body: SignUpViewBody()),
      ),
    );
  }
}
