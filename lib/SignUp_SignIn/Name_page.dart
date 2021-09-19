import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';
import 'Agree_terms_page.dart';
import 'password_page.dart';
import 'package:sida_app/firebase_db.dart';
class NamePage extends StatefulWidget {

  final String userID;
  NamePage(  this.userID,{Key key}):super(key: key);
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {

 // final fb =FirebaseDatabase.instance;
  final formKey = GlobalKey<FormState>();
  bool  is_disabled = true;
  int char_num=0;


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
  //  final ref = fb.reference();
    return Scaffold(

      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    HexColor("#2C2B69"),
                    HexColor("#121212"),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/splash_bg_opacity.png"),
                  fit: BoxFit.cover,
                )
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
              child: new Container(
                decoration: new BoxDecoration(color:  HexColor("#2C2B69").withOpacity(0.02)),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.05,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton( onPressed: (){
                    CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: true);
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
                  },
                    icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                ),
                SizedBox(height: 0.05 * screenHeight),
                Center(
                  child: Text('Enter your Name:',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans')),
                ),
                SizedBox(height: 0.05 * screenHeight),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key:formKey,
                    child: SizedBox(
                      width: 0.8* screenWidth,
                      child: TextFormField(
                        controller: controller,
                        obscureText: false,
                        style: TextStyle( color: Colors.white,fontSize: 20),
                        decoration: InputDecoration(
                               hintText: "Your Name",
                        ),
                        onChanged: (val){
                          setState(() {
                            char_num = val.length;
                          });
                          setState(() {
                            if (val.length == 1)
                              is_disabled= false;
                          });
                        },
                        validator: (val) {
                          if(val.isEmpty){return "Please fill in your Name";}
                          if(val.length>15){return "your Name can't exceed 15 characters";}
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right:20),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(char_num.toString()+'/15' , style: TextStyle( color: Colors.grey, fontSize: 10),)),
                ),

                SizedBox(height: .5 * screenHeight),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:  SizedBox(
      width: screenWidth,
      height: 0.09 * screenHeight,
      child: RaisedButton(
        color: HexColor("#FFBB00"),
        onPressed: is_disabled ? null : ()async
        {
          final form= formKey.currentState;
          if(form.validate())
          {
            ref.child(widget.userID).update({'Name': controller.text });
            Navigator.push(context, MaterialPageRoute(
               builder: (BuildContext context) => HomeScreen()));
            CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: true);
          }
        },
        child:   Text(' Next',
            style: TextStyle(
                color: Colors.white, fontSize: 20.0 )),),
    ),

    );
  }
}
