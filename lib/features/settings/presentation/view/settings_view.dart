import 'package:debt_managment_app/core/services/get_it_service.dart';
import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:debt_managment_app/features/auth/domain/repo/auth_repo.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/sign%20out/sign_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(getIt.get<AuthRepo>()),
      child: BlocListener<SignOutCubit, SignOutState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            Navigator.pushReplacementNamed(context, SignInView.routename);
          } else if (state is SignOutError) {
            showerrorDialog(
              context: context,
              title: "فشل تسجيل الخروج",
              description: "حدث خطأ ما الرجاء إعادة المحاولة",
            );
          }
        },
        child: const SettingsViewBody(),
      ),
    );
  }
}
