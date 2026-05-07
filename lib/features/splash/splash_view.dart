import 'package:debt_managment_app/core/services/token_storage.dart';
import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String routename = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    final String? token = await TokenStorage().readAccess();


    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainView.routename,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInView.routename,
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgGradient = LinearGradient(
      colors:
          isDark
              ? [AppColors.backgroundDark, AppColors.cardDark]
              : [
                AppColors.backgroundLight,
                AppColors.primary.withOpacity(0.12),
              ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final textColor = isDark ? Colors.white : AppColors.textDark;
    final subTextColor =
        isDark ? Colors.white70 : AppColors.textGrey.withOpacity(0.9);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    AppImages.imagesAppIcon,
                    width: 130,
                    height: 130,
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'سجِّلها',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'إدارة الديون بسهولة',
                    style: TextStyle(fontSize: 14, color: subTextColor),
                  ),
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballSpinFadeLoader,
                      colors: [isDark ? Colors.white : AppColors.primary],
                      strokeWidth: 2,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
