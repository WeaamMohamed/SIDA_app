import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';
import 'localization/app_localization.dart';
import 'localization/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // bool isEnglish = CacheHelper.getData(key: 'isEnglish',);
  // print('shared pref in main' + isEnglish.toString());

  runApp(MyApp());
}

class MyApp extends StatefulWidget
{
  // bool isEnglish;
  // MyApp(this.isEnglish);
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
 // SharedPreferences prefs;

  // getData() async{
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     initialPosition = prefs.getBool('pos') ?? true;
  //   });
  // }

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
   // bool _isEnglish = widget.isEnglish;


    // bool providerIsEnglish = Provider.of<DataProvider>(context).isEnglish;

    //getData();
    return MultiProvider(
      providers: [
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

          bool isEnglish = CacheHelper.getData();
          print('shared pref in main: ' + isEnglish.toString());

          //   Provider.of<DataProvider>(context, listen: false).setIsEnglishChosen(_isEnglish);

          //TODO: here is language problem
          if(CacheHelper.getData())
            return Locale('en', 'US');
          if(!CacheHelper.getData())
            return Locale('ar', 'EG');
          //TODO: use enum for language (AR, EN, DEFAULT)
          // else
          //   return supportedLocales.first;
        },

        home: HomePage(),
      ),
    );
  }
}