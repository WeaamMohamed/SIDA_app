import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sida_app/screens/SplashScreen.dart';
import 'localization/app_localization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget
{
  static void setLocale(BuildContext context, Locale locale)
  {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Locale _locale;
  void setLocale(Locale locale)
  {
    setState(()
    {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIDA - Egyptian Ride Hailing App',

      locale: _locale,

      supportedLocales:
      [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],

      localizationsDelegates:
      [
        AppLocalization.localizationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      localeResolutionCallback: (deviceLocale, supportedLocales)
      {
        for (var locale in supportedLocales)
        {
          if (locale.languageCode == deviceLocale.languageCode)
          {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      } ,

      home: SplashScreen(),
    );
  }
}