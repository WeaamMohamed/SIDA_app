import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sida_app/screens/home_screen.dart';

import 'custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:hexcolor/hexcolor.dart';


class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    CustomCheckbox All_Terms =  CustomCheckbox(
        isChecked: false,
        size: 30, iconSize: 25,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue
    );
    CustomCheckbox Term1 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);
    CustomCheckbox Term2 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);
    CustomCheckbox Term3 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);
    CustomCheckbox Term4 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);
    CustomCheckbox Term5 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);
    CustomCheckbox Term6 =    CustomCheckbox(
        isChecked: false,
        size: 25, iconSize: 20,
        selectedColor: Colors.amber, selectedIconColor: Colors.blue);

    showAlertDialog(BuildContext context) {

      // set up the button
      Widget okButton = TextButton(
        child: Text("OK", style: TextStyle(color: Colors.amber, fontSize: 20.0, fontFamily: 'spoqa_han_sans', fontWeight: FontWeight.bold)),
        onPressed: () {Navigator.of(context).pop(); },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(

        content: Text("You should agree to all the required term",  style: TextStyle(
            color: HexColor("2C2B62"), fontSize: 22.0, fontFamily: 'spoqa_han_sans', fontWeight: FontWeight.bold)),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               // crossAxisAlignment: CrossAxisAlignment,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 0.05 * screenHeight),
                 Center(
                      child: Text('Please agree to the terms and conditions ',
                          style: TextStyle(
                              color: Colors.white, fontSize: 17.0, fontFamily: 'spoqa_han_sans')),
                    ),
                    Center(
                      child: Text('to use our services',
                          style: TextStyle(
                              color: Colors.white, fontSize: 17.0, fontFamily: 'spoqa_han_sans')),
                    ),
                  SizedBox(height: 0.02 * screenHeight),
                   Center(
                      child: Row(
                        children: [
                          SizedBox(width:15),
                          All_Terms,
                          SizedBox(width:10),
                          Text('Agree to all terms ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  SizedBox(height: 0.02 * screenHeight),
                  SizedBox(height: 1,width:screenWidth-50, child: Container( color: Colors.amber,),),
                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    children: [
                      SizedBox(width:15),
                      Term1,
                      SizedBox(width:10),
                      Text('Agree to Terms of Service (Required)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                    ],
                  ),
                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width:15),
                      Term2,
                      SizedBox(width:10),
                       Flexible(
                         child: Text('''Agree to Car Rental Service Including \nDriver Placement Terms \nand Conditions (Required)''',
                            overflow: TextOverflow.ellipsis,

                            maxLines:3,
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                       ),
                    ],
                  ),
                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width:15),
                      Term3,
                      SizedBox(width:10),
                      Flexible(
                        child: Text('''Agree to Terms of Location-Based\nService (Required)''',
                          overflow: TextOverflow.ellipsis,
                          maxLines:3,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    children: [
                      SizedBox(width:15),
                      Term4,
                      SizedBox(width:10),
                      Text('Agree to Privacy Policy (Required)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                    ],
                  ),
                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width:15),
                      Term5,
                      SizedBox(width:10),
                      Flexible(
                        child: Text('''Agree to Electronic Financial\nTransaction Terms and Conditions\n(Required)''',
                          overflow: TextOverflow.ellipsis,
                          maxLines:3,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                      ),
                    ],
                  ),                  SizedBox(height: 0.02 * screenHeight),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width:15),
                      Term6,
                      SizedBox(width:10),
                      Flexible(
                        child: Text('''Agree to Consent to Receive\nMarketing Communications\n(Optional)''',
                          overflow: TextOverflow.ellipsis,
                          maxLines:3,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans' ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.07 * screenHeight),
                  Center(
                    child: Text('* You may still use the service without agreeing to',
                        style: TextStyle(
                            color: Colors.white, fontSize: 17.0, fontFamily: 'spoqa_han_sans')),
                  ),
                  Center(
                    child: Text('the optional terms.',
                        style: TextStyle(
                            color: Colors.white, fontSize: 17.0, fontFamily: 'spoqa_han_sans')),
                  ),
                  SizedBox(height: 0.3 * screenHeight),

                ],
              ),
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
            if (All_Terms.isChecked)
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
            else if ( (Term1.isChecked && Term2.isChecked &&Term3.isChecked &&Term4.isChecked &&Term5.isChecked )|| Term6.isChecked)
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MyApp()));
            else
              showAlertDialog(context);


          },

          child:   Text('Confirm',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }
}
