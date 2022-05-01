import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class LocalizationService {

  late final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService of(BuildContext context){
    return Localizations.of(context, LocalizationService);
  }

  late Map<String, String> _localizedString;

  Future<void> load() async{
    final jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    _localizedString = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedString[key];
  }

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('ta', 'IN'),
    Locale('si', 'SL')
  ];

  static Locale? localeResolutionCallBack(Locale? locale, Iterable<Locale>? supportedLocales){
    if(supportedLocales != null && locale != null){
      return supportedLocales.firstWhere((element) =>
      element.languageCode == locale.languageCode,
          orElse: ()=> supportedLocales.first);
    }

    return null;
  }

  static const LocalizationsDelegate<LocalizationService> _delegate = _LocalizationServiceDelegate();

  static const localizationsDelegate = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate
  ];

}

class _LocalizationServiceDelegate extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ta' , 'si'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async{
    LocalizationService service = LocalizationService(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationService> old) {
    return false;
  }
}

