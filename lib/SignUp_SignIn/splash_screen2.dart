import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'mobile_phone_page.dart';
import 'package:hexcolor/hexcolor.dart';

class splashscreen2 extends StatefulWidget {
  @override
  _splashscreen2State createState() => _splashscreen2State();
}

class _splashscreen2State extends State<splashscreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   AnimatedSplashScreen(
        splash:SvgPicture.asset('assets/SIDALog&NameDisassembly.svg',width: 100,height: 100),
        nextScreen: PhoneNumberPage(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
        backgroundColor: HexColor("2C2B62").withOpacity(0.923),
      ),

    );
  }
}
