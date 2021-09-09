import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization
{
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context)
  {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> localizationsDelegate = _AppLocalizationsDelegate();

  Map<String, String> _localizationStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizationStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }
  String translate(String key)
  {
    return _localizationStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization>
{
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}