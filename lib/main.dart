import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'SignUp_SignIn/mobile_phone_page.dart';
import 'package:provider/provider.dart';
import 'shared/data_handler/data_provider.dart';


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
    return MultiProvider(
      providers:[
        Provider<DataProvider>(create: (_) => DataProvider()),
        Provider<MapProvider>(create: (_) => MapProvider()),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Google Map Place Picker',
  //    home: PickerPage(),
        home:PhoneNumberPage(),
      ),
    );
  }
}