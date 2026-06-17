import 'package:debt_managment_app/core/services/local_storage_service.dart';
import 'package:debt_managment_app/core/theme/app_colors.dart';
import 'package:debt_managment_app/core/utils/app_images.dart';
import 'package:debt_managment_app/core/utils/data.dart';
import 'package:debt_managment_app/features/main/presntation/views/main_view.dart';
import 'package:debt_managment_app/features/settings/presentation/cubits/currency/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _hasAcceptedLegal = false;

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
    _OnboardingPageData(
      icon: Icons.tune_rounded,
      title: 'إعدادات البداية',
      description:
          'اختر العملة الافتراضية ووافق على سياسة الخصوصية وشروط الاستخدام.',
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
    if (!_hasAcceptedLegal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب الموافقة على سياسة الخصوصية وشروط الاستخدام.'),
        ),
      );
      return;
    }

    setState(() {
      _isFinishing = true;
    });

    await context.read<CurrencyCubit>().setCurrency(
      context.read<CurrencyCubit>().state,
    );
    await LocalStorageService.markLegalAccepted();
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
                  onPressed:
                      _isFinishing || _isLastPage
                          ? null
                          : () => _pageController.animateToPage(
                            _pages.length - 1,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOut,
                          ),
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
                      child:
                          index == _pages.length - 1
                              ? _OnboardingSetupSection(
                                isAccepted: _hasAcceptedLegal,
                                onAcceptedChanged: (value) {
                                  setState(() {
                                    _hasAcceptedLegal = value;
                                  });
                                },
                              )
                              : null,
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
                  onPressed:
                      _isFinishing || (_isLastPage && !_hasAcceptedLegal)
                          ? null
                          : _next,
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
    this.child,
  });

  final _OnboardingPageData page;
  final Color textColor;
  final Color mutedTextColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: mutedTextColor,
                    height: 1.7,
                  ),
                ),
                if (child != null) ...[const SizedBox(height: 24), child!],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingSetupSection extends StatelessWidget {
  const _OnboardingSetupSection({
    required this.isAccepted,
    required this.onAcceptedChanged,
  });

  final bool isAccepted;
  final ValueChanged<bool> onAcceptedChanged;

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<CurrencyCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        _CurrencyPickerButton(currency: currency),
        const SizedBox(height: 14),
        DecoratedBox(
          decoration: BoxDecoration(
            color:
                isDark
                    ? Colors.white.withOpacity(.06)
                    : Colors.black.withOpacity(.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CheckboxListTile(
            value: isAccepted,
            onChanged: (value) => onAcceptedChanged(value ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsetsDirectional.only(start: 6, end: 10),
            title: Wrap(
              spacing: 4,
              runSpacing: 2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('أوافق على'),
                _LegalLink(label: 'سياسة الخصوصية', url: Data.privacyPolicyUrl),
                const Text('و'),
                _LegalLink(
                  label: 'شروط الاستخدام',
                  url: Data.termsAndConditionsUrl,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyPickerButton extends StatelessWidget {
  const _CurrencyPickerButton({required this.currency});

  final AppCurrency currency;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showCurrencySheet(context),
      icon: const Icon(Icons.payments_outlined),
      label: Text(
        'العملة الافتراضية: ${currency.displayName('ar')} (${currency.code})',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void _showCurrencySheet(BuildContext context) {
    final currencyCubit = context.read<CurrencyCubit>();

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder:
          (_) => BlocProvider.value(
            value: currencyCubit,
            child: const SafeArea(child: _CurrencySheetContent()),
          ),
    );
  }
}

class _CurrencySheetContent extends StatelessWidget {
  const _CurrencySheetContent();

  @override
  Widget build(BuildContext context) {
    final currentCurrency = context.watch<CurrencyCubit>().state;

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: AppCurrency.values.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final currency = AppCurrency.values[index];
        return RadioListTile<AppCurrency>(
          value: currency,
          groupValue: currentCurrency,
          title: Text(currency.displayName('ar')),
          subtitle: Text('${currency.code} - ${currency.symbol}'),
          onChanged: (value) {
            if (value == null) return;
            context.read<CurrencyCubit>().setCurrency(value);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.underline,
        ),
      ),
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
