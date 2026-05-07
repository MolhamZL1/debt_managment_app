import 'package:debt_managment_app/core/functions/open_whatsapp.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  static const String routename = '/help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المساعدة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '🧭 كيف تستخدم التطبيق؟',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              '1. قم بإضافة عميل جديد من الزر العائم +.\n'
              '2. اختر العميل وأضف له دينًا جديدًا أو عملية دفع.\n'
              '3. يمكنك متابعة الرصيد الإجمالي ومعرفة الدين ومن الدائنون بسهولة.\n',
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              '📞 الدعم الفني',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'لأي استفسار أو اقتراح، يمكنك التواصل معنا عبر واتساب:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                openWhatsApp(context, "+963988159532");
              },
              child: Text('تواصل معنا على واتساب'),
            ),
          ],
        ),
      ),
    );
  }
}
