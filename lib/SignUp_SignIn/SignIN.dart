import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_app/screens/home_screen.dart';
import 'Name_page.dart';
import 'forget_password.dart';
import 'mobile_phone_page.dart';
import 'package:flutter/services.dart';
import 'package:sida_app/firebase_db.dart';

String mypassword='';
bool correct_password= true;
String real_password;
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
    validator:(val) {
        if(val.isEmpty){return "Please fill in your Password";}
        if (val != real_password ){
          print(val);
          print(real_password);
          return "Password is not correct.Try again";}
      return null;
    },
  );

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}


///------------------------------
/// main class of the page:
class SignIn extends StatefulWidget {

  final String user_phoneNumber;
  SignIn(  this.user_phoneNumber,{Key key}):super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

 bool correct_password= true;
  String UserName='';
  @override
  void initState(){
    super.initState();
    retrieve_name();
  }
  void retrieve_name ()async
  {
    try {
      await ref.child(widget.user_phoneNumber).once().then((DataSnapshot snapshot) async {
        setState(() {
          UserName = snapshot.value['Name'];
          real_password=snapshot.value['Password'];
        });

      });

    }
    catch(e)
    { print("you got error: $e");}
  }

  bool isdisabled= true;
  final formKey = GlobalKey<FormState>();


  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    bool showPassword = false;
    @override
    void dispose() {
      passwordController.dispose();
      super.dispose();
    }

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
                  image: AssetImage('assets/images/splash_bg_no_cairo.png'),
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
                  child: Text('Hi, ' +UserName+' !',
                      style: TextStyle(
                          color: Colors.amber, fontSize: 22.0 ,fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 0.02 * screenHeight),
                Center(
                  child: Text('Welcome back in SIDA',
                      style: TextStyle(
                        color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 0.05* screenHeight),
                Center(
                  child: Text('Enter your password',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0, )),
                ),
                SizedBox(height: 0.05 * screenHeight),
                ///Password
                Form(
                  key:formKey,
                  child: SizedBox(
                      width: 0.8* screenWidth,
                      child: PasswordFieldWidget(controller: passwordController)),
                ),
                SizedBox(height: 0.01*screenHeight,),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight*0.08,
                  child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassword( widget.user_phoneNumber)));
                      }
                      , child: Align(
                        alignment: Alignment.center,
                        child: Text('Forgot password ?', style: TextStyle(color: Colors.white70 , decoration: TextDecoration.underline, fontSize: 14),)),
                  )
                ),
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
           // await check_password();
            final form= formKey.currentState;
            if(  form.validate() )
            {

              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
            }
          },
          child:   Text(' Sign in',
              style: TextStyle(
                  color: Colors.white, fontSize: 20.0 )),),
      ),




    );
  }
}
