import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'validation_code.dart';


class PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
       //  elevation: 0,
          backgroundColor: HexColor("2C2B62").withOpacity(0.923)

        ),
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
                    child: Text('Enter your phone number:',
                        style: TextStyle(
                          color: Colors.white, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    IntlPhoneField(
                      decoration: InputDecoration(
                       // labelText: 'Type phone number',
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      initialCountryCode: null,
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                        autoValidate: false,
                     validator:(phone) =>(phone == "marim") ?
                        'Enter Valid Phone Number' : null


                    ),
                  ),


                ],

              ),
            ),
          ],
        ),
      bottomNavigationBar:  SizedBox(
        width: screenWidth,
        height: 0.121 * screenHeight,
        child: RaisedButton(
          color: HexColor("#97885F"),
          onPressed: (){

            ///TODO:check if the number already saved before in the DB go to sign in page else sign up
            ///sign up:
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Validation()));
             /// sign in:
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Validation()));
          },

          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }
}
