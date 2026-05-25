import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/local_storage_service.dart';

enum AppLanguage { ar, en, system }

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit() : super(const Locale('ar')) {
    _loadLanguage();
  }

  static const _storageKey = LocalStorageKeys.language;

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
        emit(null);
        break;
      default:
        emit(const Locale('ar'));
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

  AppLanguage get currentLanguage {
    final current = state;
    if (current == null) return AppLanguage.system;
    return current.languageCode == 'en' ? AppLanguage.en : AppLanguage.ar;
  }
}
