import 'package:flutter/material.dart';

abstract class AppColors {
  // اللون الأساسي (ثقة / مال)
  static const Color primary = Color(0xFF16A34A); // أخضر رئيسي

  // للخلفيات
  static const Color backgroundLight = Color(0xFFF9FAFB); // رمادي فاتح جداً
  static const Color backgroundDark = Color(0xFF0F1115);
  static const Color form = Color(0xFFF3F4F6); // رمادي فاتح للفورم
  static const Color border = Colors.grey;
  // البطاقات
  static const Color cardLight = Color(0xFFF9FAFB);
  static const Color cardDark = Color(0xFF1E293B);

  // النصوص
  static const Color textDark = Color(0xFF111827); // أسود غامق
  static const Color textGrey = Color(0xFF6B7280); // رمادي للنصوص الثانوية

  // الحالات
  static const Color success = Color(0xFF22C55E); // أخضر فاتح (مدفوع)
  static const Color warning = Color(0xFFFACC15); // أصفر (تنبيه)
  static const Color error = Color(0xFFDC2626); // أحمر (دين متأخر)
}
