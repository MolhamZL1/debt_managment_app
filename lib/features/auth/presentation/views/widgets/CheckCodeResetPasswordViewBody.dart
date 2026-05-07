import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../../core/utils/show_err_dialog.dart';
import '../../cubits/check code reset password/check_code_reset_password_cubit.dart';
import '../reset_password_view.dart';
import 'AuthImage.dart';

class CheckCodeResetPasswordViewBody extends StatefulWidget {
  const CheckCodeResetPasswordViewBody({super.key, required this.email});
  final String email;

  @override
  State<CheckCodeResetPasswordViewBody> createState() =>
      _CheckCodeResetPasswordViewBodyState();
}

class _CheckCodeResetPasswordViewBodyState
    extends State<CheckCodeResetPasswordViewBody> {
  String code = '';
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        const SizedBox(height: 20),
        AuthImage(),
        SizedBox(height: 20),

        Text(
          'ادخل كود التحقق',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'لقد تم ارسال كود التحقق الى الايميل الخاص بك',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: OtpPinField(
              maxLength: 5,
              onSubmit: (text) {
                code = text;
              },
              onChange: (text) {
                code = text;
              },
              otpPinFieldStyle: OtpPinFieldStyle(
                defaultFieldBorderColor: Colors.grey,
                textStyle: Theme.of(context).textTheme.headlineMedium!,
                fieldBorderRadius: 8,
                activeFieldBorderColor: Theme.of(context).colorScheme.primary,
                fieldBorderWidth: 1.5,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: BlocConsumer<
            CheckCodeResetPasswordCubit,
            CheckCodeResetPasswordState
          >(
            listener: (context, state) {
              if (state is CheckCodeResetPasswordFailure) {
                showerrorDialog(
                  context: context,
                  title: "حدث خطأ ما",
                  description: state.errorMessage,
                );
              } else if (state is CheckCodeResetPasswordSuccess) {
                Navigator.pushReplacementNamed(
                  context,
                  ResetPasswordView.routename,
                  arguments: widget.email,
                );
              }
            },
            builder:
                (context, state) => ElevatedButton(
                  onPressed: () {
                    code.length < 5
                        ? null
                        : context
                            .read<CheckCodeResetPasswordCubit>()
                            .checkCodeResetPassword(
                              email: widget.email,
                              code: code,
                            );
                  },
                  child:
                      state is CheckCodeResetPasswordLoading
                          ? SizedBox(
                            width: 25,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              colors: [Colors.white],
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(' إرسال'),
                ),
          ),
        ),
      ],
    );
  }
}
