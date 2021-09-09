// import 'package:flutter/material.dart';
// import 'package:sida_app/localization/localization_method.dart';
// import 'package:sida_app/localization/language.dart';

// import '../main.dart';

// class HomePage extends StatefulWidget
// {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       drawer: _drawerList(),
//       appBar: AppBar(
//         title: Text(translate(context,'splash_first')),
//         actions: <Widget>[
//           Padding(padding: EdgeInsets.all(8),
//           child: DropdownButton(underline: SizedBox(),
//           icon: Icon(Icons.language,
//           color: Colors.white,),
//           items: Language.langaugeList()
//           .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
//             value: lang,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(lang.flag, style: TextStyle(fontSize: 20),),
//                 Text(lang.name)
//               ],
//             ),
//           )
//           ).toList(),
//           onChanged: (Language lang){
//             _changeLanguage(lang);
//           },
//           ),
//           )
//         ],
//       ),
//       body: Container(padding: EdgeInsets.all(20),child: _mainForm(context)),
//     );
//   }

//   Form _mainForm(BuildContext context) {
//     return Form(//key: _Key,
//     child: Column(children: <Widget>[
//       Container(
//         height: MediaQuery.of(context).size.height / 4,
//         child: Center(
//           child: Text('Customer Information',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold
//           )),
//         ),
//       )
//     ],));

//   }

//   Container _drawerList(){
//     TextStyle _textStyle = TextStyle(color: Colors.white,
//     fontSize:24);
//     return Container(
//       width: MediaQuery.of(context).size.width/1.5,
//       color: Theme.of(context).primaryColor,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children:  <Widget>[
//           DrawerHeader(child: Container(height: 100,
//           child: CircleAvatar(),),),
//         ]),

//     );
//   }

//   void _changeLanguage(Language lang) {
//     Locale _temp;
//     switch(lang.languageCode)
//     {
//       case 'en':
//         _temp = Locale(lang.languageCode, 'US');
//       break;
//       case 'ar':
//         _temp = Locale(lang.languageCode, 'EG');
//       break;
//       default:
//         _temp = Locale('en', 'US');
//       break;


//     }
//     MyApp.setLocale(context, _temp);
//   }
// }