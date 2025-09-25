import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../verf_code_view.dart';
import 'sign_in_view_body.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: ListView(
        children: [
          AuthImage(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('إنشاء حساب', style: AppTextStyles.headlineSmall),
          ),
          Text(
            'الاسم',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(decoration: const InputDecoration(label: Text('الاسم'))),
          SizedBox(height: 16),
          Text(
            ' رقم الهاتف',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(label: Text('رقم الهاتف')),
          ),
          SizedBox(height: 16),
          Text(
            'البريد الالكتروني',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(label: Text('البريدالكتروني')),
          ),
          SizedBox(height: 16),

          Text(
            ' كلمة المرور',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(label: Text('كلمة المرور')),
          ),
          SizedBox(height: 16),

          Text(
            'تأكيد كلمة المرور',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(label: Text('تأكيد كلمة المرور')),
          ),
          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text(
                  'الموافقة على الشروط والاحكام',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                  Navigator.pushNamed(context, VerfCodeView.routename);
              },
              child: const Text(' إنشاء حساب'),
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
        ],
      ),
    );
  }
}
