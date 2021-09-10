import 'package:flutter/material.dart';
import 'package:sida_app/localization/animated_toggle_button.dart';
import 'package:sida_app/localization/localization_method.dart';

import '../main.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context)
  {
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
            if(index==0)
            MyApp.setLocale(context, Locale('en', 'US'));
            if(index==1)
            MyApp.setLocale(context, Locale('ar', 'EG'));
                },
      ),
      ),
    );
  }
}