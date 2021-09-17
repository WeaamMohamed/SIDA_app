import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sida_app/SignUp_SignIn/mobile_phone_page.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:flutter/services.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  final double horizontalPadding = 15;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: customWhiteAppBar(context: context, title: "Settings"),
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          //  height: size.height * 0.18,
            margin: EdgeInsets.only(top:  30),
            padding: EdgeInsets.symmetric( vertical: 30, horizontal: 10),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/profile_pic.jpg",
                  ),
                  minRadius: 40,
                  maxRadius: 40,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 5,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //TODO: change this to name from firebase
                        Text("Weaam Mohamed", style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                        SizedBox(height: 10,),

                        //TODO: change this to name from firebase
                        Text("+20 106 940 5183", style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                      ],
                    ),
                  ),
                )
              ],
            ),


          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding,
                vertical: 25),
            child: Text("Favourite Places", style: TextStyle(
              color: Color(0xffA9ACB6),
              fontSize: 16,
            ),),
          ),
         // SizedBox(height: 10,),
          _customRow(text: "Add home", icon: Icons.home,
              onTap: (){
            //TODO: Add Home,
              }),
          _customRow(text: "Add work", icon: Icons.work,
          onTap: (){
            //TODO: Add work
          }),
         _signOut(onTap: () async{
           //TODO: sign out

             await FirebaseAuth.instance.signOut().then((value) {
               print("singed out successfully");
               CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: false);
             }).onError((error, stackTrace){
               print(error.toString());
             });
             
             //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)

             Navigator.pushAndRemoveUntil<dynamic>(
               context,
               MaterialPageRoute<dynamic>(
                 builder: (BuildContext context) => PhoneNumberPage(),
               ),
                   (route) => false,//if you want to disable back feature set to false
             );

         }),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          //   child: InkWell(
          //     onTap: (){
          //       //TODO: Add work
          //     },
          //     child: Row(
          //
          //       children: [
          //         Icon(Icons.work, color: Colors.black, size: 25,),
          //         SizedBox(width: 15,),
          //         Text("Add work", style: TextStyle(
          //           fontSize: 15,
          //         ),),
          //       ],
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }

  @override
  void initState() {

    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    super.dispose();

  }

  Widget _customRow({String text, IconData icon, Function onTap,}) =>  InkWell(
    onTap: onTap,
    child: Container(

    //  margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding,
        vertical: 20,),
      child: Row(
        children: [
          SizedBox(width: 5,),
          Icon(icon, color: Colors.black, size: 25,),
          SizedBox(width: 15,),
          Text(text, style: TextStyle(
            fontSize: 15,
          ),),
        ],
      ),
    ),
  );

  Widget _signOut({Function onTap,})=> Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Divider(
        color: Color(0xffC2C9D9),
        thickness: 1,
      ),

    InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding + 4),
        margin: EdgeInsets.symmetric(vertical: 20),
          child: Text("Sign out", style: TextStyle(fontSize: 15),)),
    ),
      Divider(
        color: Color(0xffC2C9D9),
        thickness: 1,
      ),
    ],
  );
}
