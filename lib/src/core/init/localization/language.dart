import 'package:flutter/material.dart';

class LanguageManager {
  //? lazy language instance
  static LanguageManager? _instance;
  static LanguageManager get instance =>
      (_instance == null) ? _instance = LanguageManager._initial() : _instance!;
  LanguageManager._initial();
  //? languages
  final enLocale = const Locale('en');
  final trLocale = const Locale('tr');
  //? supported language
  List<Locale> get supportedLocales => [enLocale, trLocale];
}
