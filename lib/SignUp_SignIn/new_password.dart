import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'Name_page.dart';
import 'mobile_phone_page.dart';
import 'package:flutter/services.dart';
import 'package:sida_app/firebase_db.dart';
String mypassword='';
class PasswordFieldWidget extends StatefulWidget {

  final TextEditingController controller;
  const PasswordFieldWidget({
    Key key,
    this.controller,

  }) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {

  bool isHidden = false;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: widget.controller,
    style: TextStyle( color: Colors.white, fontFamily: 'spoqa',fontSize: 20),
    obscureText: isHidden,
    decoration: InputDecoration(
      hintText: 'Password',
      suffixIcon: IconButton(
        icon:
        isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        onPressed: togglePasswordVisibility,
      ),
    ),
    keyboardType: TextInputType.visiblePassword,
    autofillHints: [AutofillHints.password],
    onEditingComplete: () => TextInput.finishAutofillContext(),
    onChanged: (val){
      setState(() {
        mypassword=widget.controller.text;
        print(mypassword);

      });
    },
    validator: (val) {
      if(val.isEmpty){return "Please fill in your Password";}
      if(val.length < 4 ){return "password must be at least 4 characters";}
      if(val.length > 15 ){return "password can't exceed 15 characters";}
      return null;
    },
  );

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
///------------------------------
/// main class of the page:
class NewPassword extends StatefulWidget {

  final String user_phoneNumber;
  NewPassword(  this.user_phoneNumber,{Key key}):super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {


  bool isdisabled= true;
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    bool showPassword = false;
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
                  image: AssetImage('assets/images/splash_bg_opacity.png'),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode( HexColor("#2C2B69").withOpacity(0.2), BlendMode.dstATop),
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
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>PhoneNumberPage()));
                  },
                    icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                ),

                SizedBox(height: 0.05 * screenHeight),
                Center(
                  child: Text('Enter your New password:',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans')),
                ),
                SizedBox(height: 0.05 * screenHeight),
                ///Password
                Form(
                  key:formKey,
                  child: SizedBox(
                      width: 0.8* screenWidth,
                      child: PasswordFieldWidget(controller: passwordController)),
                ),
                SizedBox(height: 20.0,),
                SizedBox(height: .5 * screenHeight),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:   SizedBox(
        width: screenWidth,
        height: 0.09* screenHeight,
        child: RaisedButton(
          color: HexColor("#FFBB00"),
          onPressed:() async
          {
            final form= formKey.currentState;
            if(form.validate())
            {
              print("------------------");
              print(widget.user_phoneNumber);
              ref.child(widget.user_phoneNumber).update({'Password': mypassword });

             // Navigator.push(context, MaterialPageRoute(
                //  builder: (BuildContext context) => HomeScreen()));
            }
          },
          child:   Text('OK',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0 )),),
      ),




    );
  }
}
