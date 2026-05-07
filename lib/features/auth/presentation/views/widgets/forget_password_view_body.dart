import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/functions/custom_validator.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/show_err_dialog.dart';
import '../../cubits/forget password/forget_password_cubit.dart';
import '../check_code_reset_password.dart';
import 'AuthImage.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
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
              "أدخل بريدك الإلكتروني لإرسال رمز التحقق",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: FormBuilderTextField(
              name: "email",
              keyboardType: TextInputType.emailAddress,
              validator: CustomValidator.emailValidator,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(labelText: 'البريدالكتروني'),
            ),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  Navigator.pushNamed(
                    context,
                    CheckCodeResetPasswordView.routename,
                    arguments: _formKey.currentState?.value['email'] as String,
                  );
                } else if (state is ForgetPasswordFailure) {
                  showerrorDialog(
                    context: context,
                    title: "حدث خطأ",
                    description: state.errMessage,
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final email =
                          _formKey.currentState?.value['email'] as String;

                      context.read<ForgetPasswordCubit>().forgetpassword(email);
                    }
                  },
                  child:
                      state is ForgetPasswordLoading
                          ? SizedBox(
                            width: 25,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [Colors.white],
                              strokeWidth: 2,
                            ),
                          )
                          : const Text("إرسال رمز التحقق"),
                );
              },
            ),
          ),
          SizedBox(height: 16),

          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              "الرجوع لتسجيل الدخول",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.primary),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}
