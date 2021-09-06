import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sida_app/SignUp_SignIn/mobile_phone_page.dart';
import 'package:sida_app/SignUp_SignIn/validation_code.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';


void main() async
{

  // Firebase.initializeApp(name: , options: );
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapProvider>(
      create: (context) => MapProvider(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Google Map Place Picker',
  //    home: PickerPage(),
        home: FirebaseAuth.instance.currentUser == null? PhoneNumberPage(): HomeScreen(),
      ),
    );
  }
}


