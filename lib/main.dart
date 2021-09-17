import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_app/screens/edit_profile_screen.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'SignUp_SignIn/mobile_phone_page.dart';
import 'google_maps_picker/src/components/animated_pin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';
import 'google_maps_picker/src/models/pick_result.dart';
import 'google_maps_picker/src/place_picker.dart';
import 'localization/app_localization.dart';
import 'screens/settings_screen.dart';

//DON'T DELETE THIS PART//: CAN'T DELETE ANYTHING BELOW UNTILL ANOTHER COMMENT >>
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  //
  // Widget currentScreen = PhoneNumberPage();
  // FirebaseAuth.instance
  //     .authStateChanges()
  //     .listen((User user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //      currentScreen = PhoneNumberPage();
  //
  //   } else {
  //     print('User is signed in!');
  //     currentScreen = HomeScreen();
  //
  //   }
  // });

  Widget currentScreen;
  bool isSignedIn = CacheHelper.getData(key: IS_SIGNED_IN_SHARED_PREF)?? false;
  print("is Signed In ? "+ isSignedIn.toString());
  isSignedIn? currentScreen = HomeScreen(): currentScreen = PhoneNumberPage();

  runApp(MyApp(currentScreen));

}

class MyApp extends StatefulWidget {

  final Widget currentScreen;
  MyApp(this.currentScreen);
  static void setLocale(BuildContext context, Locale locale)
  {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ThemeData lightTheme = ThemeData(fontFamily: 'Spoqa Han Sans Neo').copyWith(
    // Background color of the FloatingCard
    cardColor: Color(0x00FFFFFF),
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  Locale _locale;
  void setLocale(Locale locale)
  {
    setState(()
    {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataProvider>(create: (_) => DataProvider()),
        Provider<MapProvider>(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIDA - Egyptian Ride Hailing App',
        //theme: ThemeData(fontFamily: 'Spoqa Han Sans Neo'),
        theme: lightTheme,

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

          bool isEnglish = CacheHelper.getIsEnglishData();
          print('shared pref in main is English?  ' + isEnglish.toString());

          //   Provider.of<DataProvider>(context, listen: false).setIsEnglishChosen(_isEnglish);

          //TODO: here is language problem
          if(CacheHelper.getIsEnglishData())
            return Locale('en', 'US');
          if(!CacheHelper.getIsEnglishData())
            return Locale('ar', 'EG');
          //TODO: use enum for language (AR, EN, DEFAULT)
          // else
          //   return supportedLocales.first;
        },
        //home: SettingsScreen(),
        home: widget.currentScreen,
       // home:  FirebaseAuth.instance.currentUser== null? PhoneNumberPage(): HomeScreen(FirebaseAuth.instance.currentUser.uid), //YOU CAN ONLY CHANGE THIS
    // home: FirebaseAuth.instance.currentUser== null? PhoneNumberPage(): HomeScreen(), //YOU CAN ONLY CHANGE THIS
      ),
    );
  }

  Widget getCurrentScreen() {


    if ( FirebaseAuth.instance.currentUser!= null) {
      // already signed in
      return EditProfileScreen(FirebaseAuth.instance.currentUser.uid);
    } else {
      return PhoneNumberPage();
    }

  }
}
//://DON'T DELETE THIS PART//: YOU CAN DELETE ANYTHING BELOW >>

class PickerPage extends StatefulWidget {
  const PickerPage({Key key}) : super(key: key);
  @override
  _PickerPageState createState() => _PickerPageState();
}

class _PickerPageState extends State<PickerPage> {
  PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      pinBuilder: (context, state) {
      if (state == PinState.Idle) {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/images/pickup_pin.svg'),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedPin(child: SvgPicture.asset('assets/images/pickup_pin.svg')),
                SizedBox(height: 42),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    }
      },
                          onPlacePicked: (result) {
                            selectedPlace = result;
                            print(selectedPlace);
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          
                          // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                          //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                          //   return isSearchBarFocused
                          //       ? Container()
                          //       : FloatingCard(
                          //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                          //           leftPosition: 0.0,
                          //           rightPosition: 0.0,
                          //           width: MediaQuery.of(context).size.width,
                          //           borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          //           child: state == SearchingState.Searching
                          //               ? Center(child: CircularProgressIndicator())
                          //               : RaisedButton(
                          //                   child: Text("Pick Here"),
                          //                   onPressed: () {
                          //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                          //                     //            this will override default 'Select here' Button.
                          //                     print("do something with [selectedPlace] data");
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                 ),
                          //         );
                          // },
                     );
  }
}



///
///
///
/// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sida_app/screens/edit_profile_screen.dart';
// import 'package:sida_app/screens/home_screen.dart';
// import 'SignUp_SignIn/mobile_phone_page.dart';
// import 'google_maps_picker/src/components/animated_pin.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:sida_app/shared/data_handler/data_provider.dart';
// import 'package:sida_app/shared/data_handler/map_provider.dart';
// import 'package:sida_app/shared/network/local/cache_helper.dart';
// import 'google_maps_picker/src/models/pick_result.dart';
// import 'google_maps_picker/src/place_picker.dart';
// import 'localization/app_localization.dart';
//
// //DON'T DELETE THIS PART//: CAN'T DELETE ANYTHING BELOW UNTILL ANOTHER COMMENT >>
// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Provider.debugCheckInvalidValueType = null;
//   WidgetsFlutterBinding.ensureInitialized();
//   await CacheHelper.init();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({ Key key }) : super(key: key);
//
//   static void setLocale(BuildContext context, Locale locale)
//   {
//     _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
//     state.setLocale(locale);
//   }
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   final ThemeData lightTheme = ThemeData(fontFamily: 'Spoqa Han Sans Neo').copyWith(
//     // Background color of the FloatingCard
//     cardColor: Color(0x00FFFFFF),
//     buttonTheme: ButtonThemeData(
//       // Select here's button color
//       buttonColor: Colors.black,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//
//   Locale _locale;
//   void setLocale(Locale locale)
//   {
//     setState(()
//     {
//       _locale = locale;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<DataProvider>(create: (_) => DataProvider()),
//         Provider<MapProvider>(create: (_) => MapProvider()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'SIDA - Egyptian Ride Hailing App',
//         //theme: ThemeData(fontFamily: 'Spoqa Han Sans Neo'),
//         theme: lightTheme,
//
//         locale: _locale,
//
//         supportedLocales:
//         [
//           Locale('en', 'US'),
//           Locale('ar', 'EG'),
//         ],
//
//         localizationsDelegates:
//         [
//           AppLocalization.localizationsDelegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//
//
//           localeResolutionCallback: (deviceLocale, supportedLocales)
//         {
//
//           bool isEnglish = CacheHelper.getData();
//           print('shared pref in main: ' + isEnglish.toString());
//
//           //   Provider.of<DataProvider>(context, listen: false).setIsEnglishChosen(_isEnglish);
//
//           //TODO: here is language problem
//           if(CacheHelper.getData())
//             return Locale('en', 'US');
//           if(!CacheHelper.getData())
//             return Locale('ar', 'EG');
//           //TODO: use enum for language (AR, EN, DEFAULT)
//           // else
//           //   return supportedLocales.first;
//         },
//
//         home: FirebaseAuth.instance.currentUser== null? PhoneNumberPage(): HomeScreen(FirebaseAuth.instance.currentUser.uid), //YOU CAN ONLY CHANGE THIS
//       ),
//     );
//   }
// }
// //://DON'T DELETE THIS PART//: YOU CAN DELETE ANYTHING BELOW >>
//
// class PickerPage extends StatefulWidget {
//   const PickerPage({Key key}) : super(key: key);
//   @override
//   _PickerPageState createState() => _PickerPageState();
// }
//
// class _PickerPageState extends State<PickerPage> {
//   PickResult selectedPlace;
//   @override
//   Widget build(BuildContext context) {
//     return PlacePicker(
//       pinBuilder: (context, state) {
//       if (state == PinState.Idle) {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SvgPicture.asset('assets/images/pickup_pin.svg'),
//                 SizedBox(height: 42),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Stack(
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 AnimatedPin(child: SvgPicture.asset('assets/images/pickup_pin.svg')),
//                 SizedBox(height: 42),
//               ],
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//         ],
//       );
//     }
//       },
//                           onPlacePicked: (result) {
//                             selectedPlace = result;
//                             print(selectedPlace);
//                             Navigator.of(context).pop();
//                             setState(() {});
//                           },
//
//                           // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
//                           //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
//                           //   return isSearchBarFocused
//                           //       ? Container()
//                           //       : FloatingCard(
//                           //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
//                           //           leftPosition: 0.0,
//                           //           rightPosition: 0.0,
//                           //           width: MediaQuery.of(context).size.width,
//                           //           borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//                           //           child: state == SearchingState.Searching
//                           //               ? Center(child: CircularProgressIndicator())
//                           //               : RaisedButton(
//                           //                   child: Text("Pick Here"),
//                           //                   onPressed: () {
//                           //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
//                           //                     //            this will override default 'Select here' Button.
//                           //                     print("do something with [selectedPlace] data");
//                           //                     Navigator.of(context).pop();
//                           //                   },
//                           //                 ),
//                           //         );
//                           // },
//                      );
//   }
// }