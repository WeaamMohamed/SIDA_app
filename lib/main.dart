import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'localization/app_localization.dart';
import 'localization/home_page copy.dart';


void main() async{

  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return MultiProvider(
      providers:[
        Provider<DataProvider>(create: (_) => DataProvider()),
        Provider<MapProvider>(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
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
          for (var locale in supportedLocales)
          {
            if (locale.languageCode == deviceLocale.languageCode)
            {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        } ,

        home: HomeScreen(),
      ),
    );
  }
}