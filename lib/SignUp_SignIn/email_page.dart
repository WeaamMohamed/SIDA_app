import 'dart:ui';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'password_page.dart';

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   //  elevation: 0,
      //     backgroundColor: HexColor("2C2B62").withOpacity(0.923)
      //
      // ),
      body:SingleChildScrollView(
        child: Form(
          key:formKey,
          child: Stack(
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
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/splash_bg_cairo.png"),
                    //   fit: BoxFit.cover,
                    //   colorFilter: new ColorFilter.mode( HexColor("#2C2B69").withOpacity(0.2), BlendMode.dstATop),
                    // )
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
                  child: new Container(
                    decoration: new BoxDecoration(color:  HexColor("#2C2B69").withOpacity(0.02)),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 0.05 * screenHeight),
                  Center(
                    child: Text('Enter your email:',
                        style: TextStyle(
                            color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans')),
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                  //Email
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    //  autofillHints: [AutofillHints.email],
                      //keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      style: TextStyle( color: Colors.blue, fontFamily: 'spoqa',fontSize: 20),
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                          hoverColor: Colors.blue,
                          focusColor: Colors.blue,
                          hintText: "Email",

                      ),
                      onChanged: (val){

                      //  setState(() => FormData['Email'] = val);
                      },
                      validator: (val) {
                        if(val.isEmpty){return "Please fill in your email";}
                        ///TODO: don't forget to validate that is an email
                       else
                        return null;
                      },

                    ),
                  ),
                  SizedBox(height: .5 * screenHeight),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  SizedBox(
        width: screenWidth,
        height: 0.121 * screenHeight,
        child: RaisedButton(
          color: HexColor("#97885F"),
          onPressed: (){
         // final form= formKey.currentState.validate();
          if(formKey.currentState.validate()) {
          //  Navigator.push(context, MaterialPageRoute(
            //    builder: (BuildContext context) => passWord()));
          }
                },

          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //to hide app bar and status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }
}
