import 'package:bloc/bloc.dart';

import '../../../../../core/services/local_storage_service.dart';

enum AppCurrency {
  syp(
    code: 'SYP',
    symbol: 'ل.س',
    arabicName: 'ليرة سورية',
    englishName: 'Syrian pound',
  ),
  usd(
    code: 'USD',
    symbol: r'$',
    arabicName: 'دولار أمريكي',
    englishName: 'US dollar',
  ),
  eur(code: 'EUR', symbol: '€', arabicName: 'يورو', englishName: 'Euro'),
  tryCurrency(
    code: 'TRY',
    symbol: '₺',
    arabicName: 'ليرة تركية',
    englishName: 'Turkish lira',
  ),
  sar(
    code: 'SAR',
    symbol: 'ر.س',
    arabicName: 'ريال سعودي',
    englishName: 'Saudi riyal',
  ),
  aed(
    code: 'AED',
    symbol: 'د.إ',
    arabicName: 'درهم إماراتي',
    englishName: 'UAE dirham',
  ),
  other(code: 'Coin', symbol: 'عملة', arabicName: 'اخرى', englishName: 'Other');

  const AppCurrency({
    required this.code,
    required this.symbol,
    required this.arabicName,
    required this.englishName,
  });

  final String code;
  final String symbol;
  final String arabicName;
  final String englishName;

  String displayName(String languageCode) {
    return languageCode == 'ar' ? arabicName : englishName;
  }

  static AppCurrency fromCode(String? code) {
    return AppCurrency.values.firstWhere(
      (currency) => currency.code == code,
      orElse: () => AppCurrency.syp,
    );
  }
}

class CurrencyCubit extends Cubit<AppCurrency> {
  CurrencyCubit() : super(AppCurrency.syp) {
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final saved = await LocalStorageService.getItem(LocalStorageKeys.currency);
    emit(AppCurrency.fromCode(saved));
  }

  Future<void> setCurrency(AppCurrency currency) async {
    await LocalStorageService.setItem(LocalStorageKeys.currency, currency.code);
    if (state == currency) return;
    emit(currency);
  }
}
