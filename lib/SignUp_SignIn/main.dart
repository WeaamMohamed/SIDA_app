import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'splash_screen1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Homepage',
      theme: ThemeData(
          fontFamily: 'spoqa',
        //gives a theme for the whole app design
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(),
              )
          )
      ),
      home: WelcomePage(),
    );
  }
}
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    return Scaffold(
      body:   AnimatedSplashScreen(
          splash:SvgPicture.asset('assets/SIDALogo&NameSmaller.svg',width: 20,height: 20),
          nextScreen: splashscreen1(),
          splashTransition: SplashTransition.rotationTransition,
          duration: 1000,
        backgroundColor: HexColor("2C2B62").withOpacity(0.923),
      ),

    );
  }
}
