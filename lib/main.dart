import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'package:sida_app/shared/data_handler/app_data.dart';
//import '/google_maps_picker/google_maps_place_picker.dart';
import 'SignUp_SignIn/mobile_phone_page.dart';
import 'google_maps_picker/src/components/animated_pin.dart';
import 'google_maps_picker/src/models/pick_result.dart';
import 'google_maps_picker/src/place_picker.dart';
import "package:sida_app/SignUp_SignIn/email_screen.dart";

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
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Map Place Picker',
  //    home: PickerPage(),
        home: HomeScreen(),
      ),
    );
  }
}


