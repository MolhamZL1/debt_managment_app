import 'package:debt_managment_app/core/services/local_storage_service.dart';
import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  static const routename = '/onboarding';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isFinishing = false;

  static const List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      icon: Icons.account_balance_wallet_outlined,
      title: 'تابع الديون بوضوح',
      description: 'سجل ديون العملاء ودفعاتهم واعرف الرصيد الحالي لكل عميل.',
    ),
    _OnboardingPageData(
      icon: Icons.people_alt_outlined,
      title: 'كل العملاء في مكان واحد',
      description: 'ابحث عن العملاء، راجع تفاصيلهم، وافتح كشف الحساب بسرعة.',
    ),
    _OnboardingPageData(
      icon: Icons.cloud_off_outlined,
      title: 'يعمل بدون إنترنت',
      description: 'بياناتك محفوظة محليًا على الجهاز ولا تحتاج إلى تسجيل دخول.',
    ),
  ];

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (_isFinishing) return;

    setState(() {
      _isFinishing = true;
    });

    await LocalStorageService.markOnboardingSeen();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      MainView.routename,
      (route) => false,
    );
  }

  void _next() {
    if (_isLastPage) {
      _finish();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textDark;
    final mutedTextColor = isDark ? Colors.white70 : AppColors.textGrey;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _isFinishing ? null : _finish,
                  child: const Text('تخطي'),
                ),
              ),
              const SizedBox(height: 8),
              Image.asset(AppImages.imagesAppIcon, width: 82, height: 82),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return _OnboardingPage(
                      page: page,
                      textColor: textColor,
                      mutedTextColor: mutedTextColor,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: index == _currentIndex ? 28 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color:
                          index == _currentIndex
                              ? AppColors.primary
                              : AppColors.textGrey.withOpacity(.28),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isFinishing ? null : _next,
                  child: Text(_isLastPage ? 'ابدأ الآن' : 'التالي'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.page,
    required this.textColor,
    required this.mutedTextColor,
  });

  final _OnboardingPageData page;
  final Color textColor;
  final Color mutedTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.1),
            shape: BoxShape.circle,
          ),
          child: Icon(page.icon, size: 58, color: AppColors.primary),
        ),
        const SizedBox(height: 36),
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: mutedTextColor, height: 1.7),
        ),
      ],
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
