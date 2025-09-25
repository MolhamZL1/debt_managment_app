import 'package:debt_managment_app/core/theme/app_text_styles.dart';
import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';
class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: ListView(
        children: [
          AuthImage(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('تسجيل الدخول', style: AppTextStyles.headlineSmall),
          ),

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: GestureDetector(
              onTap: () {
              
              },
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
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('تسجيل الدخول'),
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

class AuthImage extends StatelessWidget {
  const AuthImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Image.asset(AppImages.imagesAppIcon),
      ),
    );
  }
}
