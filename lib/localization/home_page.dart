import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sida_app/localization/animated_toggle_button.dart';
import 'package:sida_app/localization/localization_method.dart';

import '../main.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

bool position;

class _HomePageState extends State<HomePage>
{
  SharedPreferences prefs;

  saveData(bool position) async {
  prefs = await SharedPreferences.getInstance();
  prefs.setBool('pos', position);
}

  getData() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      initialPosition = prefs.getBool('pos') ?? true;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context,'splash_first')),
        actions: <Widget>[
          Padding(padding: EdgeInsets.all(8),
          )
        ],
      ),
      body: Container(padding: EdgeInsets.all(10),
        child: AnimatedToggle(
          values: ['EN','AR'],
          onToggleCallback: (index) {
            if(initialPosition==true)
            {
              MyApp.setLocale(context, Locale('en', 'US'));
              saveData(true);
            }
            if(initialPosition==false)
            {
              MyApp.setLocale(context, Locale('ar', 'EG'));
              saveData(false);
            }
                },
      ),
      ),
    );
  }
}