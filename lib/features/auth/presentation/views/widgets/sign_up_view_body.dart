import 'package:debt_managment_app/features/auth/presentation/cubits/sign%20up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/utils/show_err_dialog.dart';
import '../verf_code_view.dart';
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text(
              'إنشاء حساب',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SignUpTextFieldSection(formKey: _formKey),
          SizedBox(
            width: 200,
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  showerrorDialog(
                    context: context,
                    title: "فشل إنشاء الحساب",
                    description: state.errMessage,
                  );
                }
                if (state is SignUpSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    VerfCodeView.routename,
                    arguments: _formKey.currentState?.value['email'],
                  );
                }
              },
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
                child: Text(
                  ' تسجيل الدخول',
                  style: Theme.of(context).textTheme.bodyMedium,
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
