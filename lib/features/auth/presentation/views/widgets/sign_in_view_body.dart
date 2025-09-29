import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:debt_managment_app/features/auth/presentation/cubits/sign%20in/sign_in_cubit.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'AuthImage.dart';
import 'SignInTextFieldSection.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
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
            child: Text('تسجيل الدخول', style: AppTextStyles.headlineSmall),
          ),
          SignInTextFieldSection(formKey: _formKey),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                ' هل نسيت كلمة المرور؟',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final email =
                          _formKey.currentState?.value['email'] as String;
                      final password =
                          _formKey.currentState?.value['password'] as String;
                      context.read<SignInCubit>().signIn(email, password);
                    }
                  },
                  child:
                      state is SignInLoading
                          ? SizedBox(
                            width: 25,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [Colors.white],
                              strokeWidth: 2,
                            ),
                          )
                          : const Text('تسجيل الدخول'),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ليس لديك حساب؟',
                style: TextStyle(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SignUpView.routename),
                child: const Text('إنشاء حساب'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
