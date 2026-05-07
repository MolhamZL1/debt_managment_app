import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../../core/utils/show_err_dialog.dart';
import '../../cubits/verfy email/verfy_email_cubit.dart';
import '../sign_in_view.dart';

class VerfCodeViewBody extends StatefulWidget {
  const VerfCodeViewBody({super.key, required this.email});
  final String email;

  @override
  State<VerfCodeViewBody> createState() => _VerfCodeViewBodyState();
}

class _VerfCodeViewBodyState extends State<VerfCodeViewBody> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        const SizedBox(height: 20),

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
          child: BlocConsumer<VerfyEmailCubit, VerfyEmailState>(
            listener: (context, state) {
              if (state is VerfyEmailFailure) {
                showerrorDialog(
                  context: context,
                  title: "حدث خطأ ما",
                  description: state.message,
                );
              } else if (state is VerfyEmailSucces) {
                Navigator.pushReplacementNamed(context, SignInView.routename);
              }
            },
            builder:
                (context, state) => ElevatedButton(
                  onPressed: () {
                    code.length < 5
                        ? null
                        : context.read<VerfyEmailCubit>().verfyEmail(
                          email: widget.email,
                          code: code,
                        );
                  },
                  child:
                      state is VerfyEmailLoading
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
