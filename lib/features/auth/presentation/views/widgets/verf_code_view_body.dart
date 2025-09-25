import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../../../../core/theme/app_text_styles.dart';

class VerfCodeViewBody extends StatelessWidget {
  const VerfCodeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      children: [
        const SizedBox(height: 20),

        const Text('ادخل كود التحقق', style: AppTextStyles.headlineSmall),
        SizedBox(height: 10),
        Text(
          'لقد تم ارسال كود التحقق الى الايميل الخاص بك',
          style: AppTextStyles.bodyMedium,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: OtpTextField(
            borderRadius: BorderRadius.circular(8),
            fieldWidth: 40,
            numberOfFields: 5,
            borderColor: AppColors.primary,
            focusedBorderColor: AppColors.primary,
            showFieldAsBox: true,

            onCodeChanged: (String code) {},

            onSubmit: (String verificationCode) {
              //   controller.goTosucessSignUp( verificationCode);
            }, // end onSubmit
          ),
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(onPressed: () {}, child: const Text(' إرسال')),
        ),
      ],
    );
  }
}
