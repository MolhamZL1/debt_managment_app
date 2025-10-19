import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/local_storage_service.dart';

enum AppLanguage { ar, en, system }

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(Locale("ar")) {
    _loadLanguage();
  }

  static const _storageKey = LocalStorageKeys.language;

  //static const supportedLocales = <Locale>[Locale('en'), Locale('ar')];

  Future<void> _loadLanguage() async {
    final saved = await LocalStorageService.getItem(_storageKey);
    switch (saved) {
      case 'ar':
        emit(const Locale('ar'));
        break;
      case 'en':
        emit(const Locale('en'));
        break;
      case 'system':
        emit(Locale("ar"));
        break;
      default:
        emit(Locale("ar"));
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    switch (lang) {
      case AppLanguage.ar:
        await LocalStorageService.setItem(_storageKey, 'ar');
        emit(const Locale('ar'));
        break;
      case AppLanguage.en:
        await LocalStorageService.setItem(_storageKey, 'en');
        emit(const Locale('en'));
        break;
      case AppLanguage.system:
        await LocalStorageService.setItem(_storageKey, 'system');
        emit(null);
        break;
    }
  }

  // /// كود اللغة الحالي للعرض في الإعدادات
  // String get currentCode {
  //   final s = state;
  //   if (s == null) return 'system';
  //   return s.languageCode; // 'ar' أو 'en'
  // }
}
