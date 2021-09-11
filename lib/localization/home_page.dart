// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sida_app/models/animated_toggle_button.dart';
// import 'package:sida_app/localization/localization_method.dart';
// import 'package:sida_app/shared/data_handler/data_provider.dart';
// import 'package:sida_app/shared/network/local/cache_helper.dart';

// import '../main.dart';

// class HomePage extends StatefulWidget
// {
//   //
//   // bool isEnglish;
//   // HomePage(this.isEnglish);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// //bool position;

// class _HomePageState extends State<HomePage>
// {
//   // SharedPreferences prefs;
//   //
//   // saveData(bool position) async {
//   //   prefs = await SharedPreferences.getInstance();
//   //   prefs.setBool('pos', position);
//   // }

//   // getData() async{
//   //  // prefs = await SharedPreferences.getInstance();
//   //   setState(() {
//   //     initialPosition = prefs.getBool('pos') ?? true;
//   //   });
//   // }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // Provider.of<DataProvider>(context, listen: false)
//     //     .setIsEnglishChosen(CacheHelper.getDataIsEnglish(key: 'isEnglish', context: context));

//   }

//   @override
//   Widget build(BuildContext context)
//   {

//     // getData();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(translate(context,'splash_first')),
//         actions: <Widget>[
//           Padding(padding: EdgeInsets.all(8),
//           )
//         ],
//       ),
//       body: Container(padding: EdgeInsets.all(10),
//         child: AnimatedToggle(
//           values: ['EN','AR'],
//           onToggleCallback: (index) {

//             print("home index " + index.toString());
//          //   Provider.of<DataProvider>(context, listen: false).toggleLanguage();
//             if(index)
//             {
//               MyApp.setLocale(context, Locale('en', 'US'));
//              // saveData(true);
//             }
//             else
//             {
//               MyApp.setLocale(context, Locale('ar', 'EG'));
//            //   saveData(false);
//             }



//             // if(initialPosition==true)
//             // {
//             //   MyApp.setLocale(context, Locale('en', 'US'));
//             //   saveData(true);
//             // }
//             //
//             // if(initialPosition==false)
//             // {
//             //   MyApp.setLocale(context, Locale('ar', 'EG'));
//             //   saveData(false);
//             // }
//           },
//         ),
//       ),
//     );
//   }
// }