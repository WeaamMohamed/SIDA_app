import 'package:flutter/material.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/localization/language.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../main.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

Locale _temp;

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
      body: Container(padding: EdgeInsets.all(20),child: ToggleSwitch(
            minWidth: 44,
            minHeight: 28.0,
            cornerRadius: 28.0,
            fontSize: 11.0,
            initialLabelIndex: 0,
            activeBgColor: Color(0x80f4b204),
            activeFgColor: Color(0xffffffff),
            inactiveBgColor: Color(0xff000000),
            inactiveFgColor: Color(0xffffffff),
            labels: ['AR', 'EN'],
            onToggle: (index) {
              print('switched to: $index');
              if(index==1)
              _temp = Locale('en', 'US');
              if(index==0)
              _temp = Locale('ar', 'EG');
              else
              _temp = Locale('en', 'US');
              MyApp.setLocale(context, _temp);
            }
          ),
          ),
    );
  }
}