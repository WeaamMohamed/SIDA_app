import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'splash_screen2.dart';

class splashscreen1 extends StatefulWidget {
  @override
  _splashscreen1State createState() => _splashscreen1State();
}

class _splashscreen1State extends State<splashscreen1> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:   AnimatedSplashScreen(
          splash:SvgPicture.asset('assets/SIDALogo&NameSmaller.svg',width: 60,height: 60),
          nextScreen: splashscreen2(),
          splashTransition: SplashTransition.fadeTransition,
          duration: 1000,
          backgroundColor: HexColor("2C2B62").withOpacity(0.923),
        ),

      );
  }
}


