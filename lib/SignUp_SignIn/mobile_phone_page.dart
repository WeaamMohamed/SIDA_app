import 'dart:ffi';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'validation_code.dart';
import 'splash_screen1.dart';



enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  set verificationId(String verification_Id) {
    verificationId=verification_Id;
  }

  @override
  Widget build(BuildContext context) {

      final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
      var formKey = GlobalKey<FormState>();


      MobileVerificationState currentState =
        MobileVerificationState.SHOW_MOBILE_FORM_STATE;

    final phoneController = TextEditingController();
    final otpController = TextEditingController();

    FirebaseAuth _auth = FirebaseAuth.instance;

    String verificationId;

    bool showLoading = false;

    void signInWithPhoneAuthCredential(
        PhoneAuthCredential phoneAuthCredential) async {
      setState(() {
        showLoading = true;
      });

      try {
        final authCredential =
        await _auth.signInWithCredential(phoneAuthCredential);

        setState(() {
          showLoading = false;
        });

        if(authCredential?.user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> splashscreen1()));
        }

      } on FirebaseAuthException catch (e) {
        setState(() {
          showLoading = false;
        });

        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
    ///---------------------------------------------------------------------
    getMobileFormWidget(context) {
      return  SingleChildScrollView(
        child: Form(
          key: formKey,
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
                    image: DecorationImage(
                      image: AssetImage("assets/BG.jpg"),
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
              Column(
                children: [
                  SizedBox(height: 0.05 * screenHeight),
                  Center(
                    child: Text('Enter your phone number:',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),
                  ),
                  SizedBox(height: 0.05 * screenHeight),

                        TextField(
                          controller: phoneController,

                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'phone number',
                        ),
                        ),


                  SizedBox(
                    width: screenWidth,
                    height: 0.121 * screenHeight,
                    child: RaisedButton(
                      color: HexColor("#97885F"),
                      onPressed: () async {
                        print(phoneController.text);
                        setState(() {
                          showLoading = true;
                        });

                        await _auth.verifyPhoneNumber(
                          phoneNumber: phoneController.text,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            //signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text(verificationFailed.message)));
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
                      },

                      child:   Text(' Next',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
///-------------------------------------------------------
    ///
    getOtpFormWidget(context) {
      return  Stack(
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
                  image: AssetImage("assets/BG.jpg"),
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
                SizedBox(height: 0.05 * screenHeight),
                Center(
                  child: Text(' Enter the verification code sent to ***** ',
                      style: TextStyle(
                          color: Colors.white, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),
                ),
                SizedBox(height: 0.05 * screenHeight),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      appContext: context,
                      textStyle: TextStyle( color: Colors.blue, fontFamily: 'spoqa',fontSize: 25,fontWeight: FontWeight.bold),
                      length: 6,
                      onChanged: (value)
                      {    print(value);
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 60,
                        fieldWidth: 40,
                        inactiveColor: HexColor("#2C2B69"),
                        activeColor:Colors.amber,
                        selectedColor:  Colors.blue,
                        inactiveFillColor: Colors.red,
                      ),
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          //     blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      }
                  ),
                ),
                SizedBox(height: .5 * screenHeight),
                SizedBox(
                  width: screenWidth,
                  height: 0.121 * screenHeight,
                  child: RaisedButton(
                    color: HexColor("#97885F"),
                    onPressed: () async {
                      PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: otpController.text);

                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    },

                    child:   Text('Verify',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
                ),
              ],
            ),
          )
        ],
      );
    }
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        )
    );
  }
}
