import 'package:debt_managment_app/features/auth/presentation/cubits/sign%20up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/theme/app_text_styles.dart';
import 'AuthImage.dart';
import 'SignUpTextFieldSection.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ListView(
        children: [
          SizedBox(height: 48),
          AuthImage(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('إنشاء حساب', style: AppTextStyles.headlineSmall),
          ),
          SignUpTextFieldSection(formKey: _formKey),
          SizedBox(
            width: 200,
            child: BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final name =
                          _formKey.currentState?.value['name'] as String;
                      final phoneNumber =
                          _formKey.currentState?.value['number'] as String;
                      final email =
                          _formKey.currentState?.value['email'] as String;
                      final password =
                          _formKey.currentState?.value['password'] as String;
                      final passwordConfirmation =
                          _formKey.currentState?.value['password_confirmation']
                              as String;
                      context.read<SignUpCubit>().signUp(
                        name,
                        phoneNumber,
                        email,
                        password,
                        passwordConfirmation,
                      );
                    }
                  },
                  child:
                      state is SignUpLoading
                          ? SizedBox(
                            width: 25,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [Colors.white],
                              strokeWidth: 2,
                            ),
                          )
                          : const Text('إنشاء حساب'),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('  لديك حساب؟', style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  ' تسجيل الدخول',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
