import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/utils/show_err_dialog.dart';
import '../../cubits/reset password/reset_password_cubit.dart';
import '../sign_in_view.dart';
import 'AuthImage.dart';
import 'CustomPasswordTextField.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ListView(
          children: [
            SizedBox(height: 48),
            AuthImage(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text(
                "أدخل كلمة مرور جديدة لحسابك",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              ' كلمة المرور',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            CustomPasswordTextField(
              name: 'password',
              label: 'كلمة المرور',
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
            ),

            const SizedBox(height: 16),
            Text(
              'تأكيد كلمة المرور',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            CustomPasswordTextField(
              name: 'password_confirmation',
              label: 'تأكيد كلمة المرور',
              isPasswordConfirm: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordFailure) {
                    showerrorDialog(
                      context: context,
                      title: "حدث خطأ",
                      description: state.errorMessage,
                    );
                  } else if (state is ResetPasswordSuccess) {
                    Navigator.pushReplacementNamed(
                      context,
                      SignInView.routename,
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final password =
                            _formKey.currentState?.value['password'] as String;
                        final passwordConfirmation =
                            _formKey
                                    .currentState
                                    ?.value['password_confirmation']
                                as String;

                        context.read<ResetPasswordCubit>().resetPassword(
                          email: widget.email,
                          password: password,
                          passwordConfirmation: passwordConfirmation,
                        );
                      }
                    },
                    child:
                        state is ResetPasswordLoading
                            ? SizedBox(
                              width: 25,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              ),
                            )
                            : const Text('تعيين كلمة المرور'),
                  );
                },
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
