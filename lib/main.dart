import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/app_localization.dart';
import 'localization/home_page.dart';
import 'localization/animated_toggle_button.dart';

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
  SharedPreferences prefs;

  getData() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      initialPosition = prefs.getBool('pos') ?? true;
    });
  }
  
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
    getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIDA - Egyptian Ride Hailing App',
      theme: ThemeData(fontFamily: 'Spoqa Han Sans Neo'),

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
        if(initialPosition==true)
        return Locale('en', 'US');
        if(initialPosition==false)
        return Locale('ar', 'EG');
        else
        return supportedLocales.first;
      },

      home: HomePage(),
    );
  }
}