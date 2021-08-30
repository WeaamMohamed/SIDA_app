import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'email_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//import 'package:pin_code_fields/pin_code_fields.dart';

class Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
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
                ],
              ),
            )
          ],
        ),
      bottomNavigationBar:  SizedBox(
        width: screenWidth,
        height: 0.121 * screenHeight,
        child: RaisedButton(
          color: HexColor("#97885F"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Email()));
          },

          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }
}
