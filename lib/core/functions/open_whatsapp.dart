import 'package:debt_managment_app/core/utils/show_err_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(BuildContext context, String phoneNumber) async {
  final uri = Uri.parse("https://wa.me/$phoneNumber");
  final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!ok && context.mounted) {
    showerrorDialog(
      context: context,
      title: "فشل فتح الواتساب",
      description: "تعذر فتح الواتساب ربما لا تملك التطبيق",
    );
  }
}
