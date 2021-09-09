import 'dart:ffi';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'Name_page.dart';
import 'password_page.dart';
import 'package:sida_app/firebase_db.dart';
import 'SignIN.dart';


enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

String myphoneNumber='';
class PhoneNumberPage extends StatefulWidget {

  PhoneNumberPage({this.app});
  final FirebaseApp app;
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {


  //final fb =FirebaseDatabase.instance;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  String verificationId;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  var formKey = GlobalKey<FormState>();

  final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //String phone_number;

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {

    print("helpppppppppppppppppppppppppppppp");
    setState(() {
      showLoading = true;
    });

    try {
      print("tryyyyyyyyyyyyyy");
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> passWord(myphoneNumber)));
      }

    } on FirebaseAuthException catch (e) {
      print("onnnnnnnnnnnnnnn");
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  String dropdownvalue = '+20';
  String code_country;
  var items =
  ['+7 840','+93','+355','+213','+1 684','+376','+244','+1 264','+1 268','+54','+374','+297','+247','+61','+672','+43','+994','+1 242','+973','+880','+1 246','+1 268','+375','+32','+501','+229','+1 441','+975','+591','+387','+267','+55','+246','+1 284','+673','+359','+226','+257','+855','+237','+1','+238','+ 345','+236','+235','+56','+86','+61','+61','+57','+269','+242','+243','+682','+506','+385','+53','+599','+537','+420','+45','+246','+253','+1 767','+1 809','+670','+56','+593','+20','+503','+240','+291','+372','+251','+500','+298','+679','+358','+33','+596','+594','+689','+241','+220','+995','+49','+233','+350','+30','+299','+1 473','+590','+1 671','+502','+224','+245','+595','+509','+504','+852','+36','+354','+91','+62','+98','+964','+353','+972','+39','+225','+1 876','+81','+962','+7 7','+254','+686','+965','+996','+856','+371','+961','+266','+231','+218','+423','+370','+352','+853','+389','+261','+265','+60','+960','+223','+356','+692','+596','+222','+230','+262','+52','+691','+1 808','+373','+377','+976','+382','+1664','+212','+95','+264','+674','+977','+31','+599','+1 869','+687','+64','+505','+227','+234','+683','+672','+850','+1 670','+47','+968','+92','+680','+970','+507','+675','+595','+51','+63','+48','+351','+1 787','+974','+262','+40','+7','+250','+685','+378','+966','+221','+381','+248','+232','+65','+421','+386','+677','+27','+500','+82','+34','+94','+249','+597','+268','+46','+41','+963','+886','+992','+255','+66','+670','+228','+690','+676','+1 868','+216','+90','+993','+1 649','+688','+1 340','+256','+380','+971','+44','+1','+598','+998','+678','+58','+84','+1 808','+681','+967','+260','+255','+263',];
  //bool is_disabled = true;
  bool is_exists = false;
  @override
  Widget build(BuildContext context) {


    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    void onpressed_phone () async
    {
     // final form= formKey.currentState;
    //  if(form.validate())
      {
        try {
          await ref.child(myphoneNumber).once().then((DataSnapshot snapshot) async {

            if ( snapshot.value != null)
              {
                print("++++++++++++++");
                is_exists =true;
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => SignIn(myphoneNumber)));
              }
            else
              {
                ref.child(myphoneNumber).set({'Phonenumber': myphoneNumber , 'Password':'' , 'Name' :''});
              }

          });

        }
        catch(e)
        { print("you got error: $e");}

        /// if already stored in data base leave the function no need to send verification code
        print(is_exists);
        if ( is_exists )
            return;



        setState(() {
          print("2222222222222");
          showLoading = true;
        });
        print("&&&&&&&&&&&&");
        await _auth.verifyPhoneNumber(
          phoneNumber: '+20'+myphoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            print("33333333");
            setState(() {
              showLoading = false;
            });
            //signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          verificationFailed: (verificationFailed) async {
            print("4444444444");
            setState(() {
              showLoading = false;
            });
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text(verificationFailed.message)));
          },
          codeSent: (verificationId, resendingToken) async {
            print("55555555");
            setState(() {
              showLoading = false;
              currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
              this.verificationId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) async {
            print("777777777777777777777");
          },
        );
      }
    }
    void onpressed_code () async {
     PhoneAuthCredential phoneAuthCredential =
     PhoneAuthProvider.credential(
         verificationId: verificationId, smsCode: otpController.text);
     signInWithPhoneAuthCredential(phoneAuthCredential);
   }
    ///---------------------------------------------------------------------
    getMobileFormWidget(context) {
      return  Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight,
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
                    image: AssetImage("assets/images/splash_bg_no_cairo.png"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode( HexColor("#2C2B69").withOpacity(0.2), BlendMode.dstATop),
                  )
              ),
               child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
                child: new Container(
                  decoration: new BoxDecoration(color:  HexColor("#2C2B69").withOpacity(0.02)),
                  child:  Column(
                    children: [
                      SizedBox(height: screenHeight*0.05,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton( onPressed: (){},
                          icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                      ),
                      SizedBox(height: screenHeight*0.07,),
                      Text('Enter your phone number:',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0 )),
                      SizedBox(height: screenHeight*0.06,),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment:Alignment.bottomCenter,
                              child: DropdownButton(
                                style: TextStyle(color: Colors.white, fontSize: 15),
                                value: dropdownvalue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items:items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items)
                                  );
                                }
                                ).toList(),
                                onChanged: (String newValue){
                                  setState(() {
                                    dropdownvalue = newValue;
                                    code_country=newValue;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: screenWidth*0.04,),
                            Form(
                              key:formKey,
                              child: SizedBox(
                                width: 0.56* screenWidth,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    hintText: 'phone number',
                                    hintStyle:TextStyle(color: Colors.white) ,

                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      myphoneNumber= phoneController.text;
                                    });

                                  },
                                  validator: (val) {
                                    if(val.isEmpty){return "Please fill in your Phone Number";}
                                    final number = num.tryParse(val);
                                    if (number == null) {
                                      return "Invalid phone number!";
                                    }
                                    if(val.length != 11  ){return "Phone number must be 11 digits!";}
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight*0.5,),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
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
                  image: AssetImage("assets/images/splash_bg_no_cairo.png"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode( HexColor("#2C2B69").withOpacity(0.2), BlendMode.dstATop),
                )
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 1.0),
              child: new Container(
                decoration: new BoxDecoration(color:  HexColor("#2C2B69").withOpacity(0.02)),
                child:  Column(
                  children: [
                    SizedBox(height: screenHeight*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton( onPressed: (){
                        setState(() {
                          currentState = MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                        });

                      },
                        icon:Icon(Icons.arrow_back) ,color: Colors.white,),
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    SizedBox(height: 0.02 * screenHeight),
                    Center(
                      child: Text(' Enter the verification code sent to ' ,
                          style: TextStyle(
                              color: Colors.white, fontSize: 17.0)),
                    ),
                    SizedBox(height: screenHeight*0.01,),
                    Center(
                      child: Text( myphoneNumber,
                          style: TextStyle(
                              color: Colors.blue, fontSize: 17.0)),
                    ),
                    SizedBox(height: 0.05 * screenHeight),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: PinCodeTextField(
                          controller: otpController,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          appContext: context,
                          textStyle: TextStyle( color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),
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
                         //  is_disabled=false;
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: screenWidth,
          height: screenHeight,
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
                image: AssetImage("assets/images/splash_bg_no_cairo.png"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode( HexColor("#2C2B69").withOpacity(0.2), BlendMode.dstATop),
              )
          ),
          child: showLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ),
        bottomNavigationBar:      SizedBox(
          width: screenWidth,
          height: 0.09 * screenHeight,
          child: RaisedButton(
              color: HexColor("#FFBB00"),
              onPressed:
               currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE ? onpressed_phone:onpressed_code,
            child:   Text(' Next', style: TextStyle( color: Colors.white, fontSize: 20.0 )),),
    ),
    );
  }
}
