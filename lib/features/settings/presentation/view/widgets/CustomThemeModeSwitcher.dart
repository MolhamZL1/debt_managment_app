import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../cubits/theme/theme_cubit.dart';

class CustomThemeModeSwitcher extends StatelessWidget {
  const CustomThemeModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 20,
        width: 40,
        child: FittedBox(
          child: DayNightSwitch(
            value: context.watch<ThemeCubit>().state == ThemeMode.dark,
            dayColor: AppColors.primary.withOpacity(.6),
            onChanged: (value) {
              context.read<ThemeCubit>().setTheme(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
        ),
      ),
    );
  }
}
