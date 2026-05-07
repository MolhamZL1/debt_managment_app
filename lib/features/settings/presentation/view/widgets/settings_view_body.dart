import 'dart:convert';

import 'package:debt_managment_app/core/services/local_storage_service.dart';
import 'package:debt_managment_app/core/utils/data.dart';
import 'package:debt_managment_app/core/utils/show_question_dialog.dart';
import 'package:debt_managment_app/features/auth/data/model/user_model.dart';
import 'package:debt_managment_app/features/auth/domain/entity/user_entity.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/sign%20out/sign_out_cubit.dart';
import 'package:debt_managment_app/features/settings/presentation/view/about_us_view.dart';
import 'package:debt_managment_app/features/settings/presentation/view/help_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/app_colors.dart';

import 'CustomThemeModeSwitcher.dart';
import 'SettingsCardSection.dart';
import 'TextHeaderSettings.dart';
import 'settings_tile.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  UserEntity? userEntity;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final String? userData = await LocalStorageService.getItem(
      LocalStorageKeys.user,
    );

    if (userData != null) {
      try {
        final Map<String, dynamic> json =
            jsonDecode(userData) as Map<String, dynamic>;

        final user = UserModel.fromJson(json).toEntity();

        setState(() {
          userEntity = user;
        });
      } catch (e) {
        debugPrint('Error parsing user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const TextHeaderSettings('الحساب'),
        SettingsCardSection(
          children: [
            SettingsTile(
              title: 'معلومات الحساب',
              subtitle: userEntity?.email ?? '...',
              leadingIcon: Icons.person_outline,
              trailingWidget: Text(userEntity?.name ?? '...'),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const TextHeaderSettings('التفضيلات'),
        SettingsCardSection(
          children: [
            const SettingsTile(
              title: 'اللغة',
              subtitle: 'العربية',
              leadingIcon: Icons.public,
            ),
            const Divider(),
            SettingsTile(
              title: 'الثيم',
              subtitle: isDark ? 'داكن' : 'فاتح',
              leadingIcon: Icons.brightness_6_outlined,
              trailingWidget: const CustomThemeModeSwitcher(),
            ),
          ],
        ),

        const SizedBox(height: 16),
        const TextHeaderSettings('المساعدة والدعم'),
        SettingsCardSection(
          children: [
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(Data.privacyPolicyUrl));
              },
              child: const SettingsTile(
                title: "سياسة الخصوصية",
                leadingIcon: Icons.privacy_tip_outlined,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(Data.termsAndConditionsUrl));
              },
              child: const SettingsTile(
                title: "الشروط و الاحكام",
                leadingIcon: Icons.gavel_outlined,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, HelpPage.routename);
              },
              child: const SettingsTile(
                title: 'المساعدة',
                leadingIcon: Icons.help_outline,
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AboutUsPage.routename);
              },
              child: const SettingsTile(
                title: 'من نحن',
                leadingIcon: Icons.info_outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
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
          icon: const Icon(Icons.logout),
          label: BlocBuilder<SignOutCubit, SignOutState>(
            builder: (context, state) {
              if (state is SignOutLoading) {
                return const SizedBox(
                  width: 25,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: [Colors.white],
                    strokeWidth: 2,
                  ),
                );
              }
              return const Text('تسجيل الخروج');
            },
          ),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
        ),
        const SizedBox(height: 12),
        const Center(child: Text('سجلها الإصدار 1.0.0')),
      ],
    );
  }
}
