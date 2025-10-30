import 'package:debt_managment_app/core/utils/show_question_dialog.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/sign%20out/sign_out_cubit.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/theme/app_colors.dart';
import 'CustomThemeModeSwitcher.dart';
import 'SettingsCardSection.dart';
import 'TextHeaderSettings.dart';
import 'settings_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const TextHeaderSettings('الحساب'),
        SettingsCardSection(
          children: [
            GestureDetector(
              onTap:
                  () => {Navigator.pushNamed(context, ProfileView.routename)},
              child: SettingsTile(
                title: 'معلومات الحساب',
                subtitle: 'mohammed@example.com',
                leadingIcon: Icons.person_outline,
                trailingWidget: Text('محمد السعدي'),
              ),
            ),
          ],
        ),

        SizedBox(height: 16),
        const TextHeaderSettings('التفضيلات'),
        SettingsCardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              leadingIcon: Icons.public,
            ),
            Divider(),
            SettingsTile(
              title: 'الثيم',
              subtitle: isDark ? 'داكن' : 'فاتح',
              leadingIcon: Icons.brightness_6_outlined,
              trailingWidget: CustomThemeModeSwitcher(),
            ),
          ],
        ),
        SizedBox(height: 16),
        const TextHeaderSettings('المساعدة والدعم'),
        SettingsCardSection(
          children: [
            SettingsTile(
              title: "سياسة الخصوصية",
              leadingIcon: Icons.privacy_tip_outlined,
            ),
            Divider(),
            SettingsTile(
              title: "الشروط و الاحكام",
              leadingIcon: Icons.gavel_outlined,
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, HelpPage.routename);
              },
              child: SettingsTile(
                title: 'المساعدة',
                leadingIcon: Icons.help_outline,
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AboutUsPage.routename);
              },
              child: SettingsTile(
                title: 'من نحن',
                leadingIcon: Icons.info_outline,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            showQuestionDialog(
              context: context,
              title: "تسجيل الخروج",
              description: "هل انت متأكد انك تريد تسجيل الخروج؟",
              btnOkOnPress: () {
                context.read<SignOutCubit>().signOut();
              },
            );
          },
          icon: Icon(Icons.logout),
          label: BlocBuilder<SignOutCubit, SignOutState>(
            builder: (context, state) {
              if (state is SignOutLoading) {
                return SizedBox(
                  width: 25,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: [Colors.white],
                    strokeWidth: 2,
                  ),
                );
              }
              return Text('تسجيل الخروج');
            },
          ),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
        ),
        SizedBox(height: 12),
        Center(child: Text('سجلها الإصدار 1.0.0')),
      ],
    );
  }
}
