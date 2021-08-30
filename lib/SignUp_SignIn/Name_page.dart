import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Agree_terms_page.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();

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
                    child: TextFormField(
                      controller: controller,
                      obscureText: false,
                      style: TextStyle( color: Colors.white, fontFamily: 'spoqa',fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Your Name",
                      ),
                      onChanged: (val){
                        // setState(() => FormData['Password'] = val);
                      },
                      validator: (val) {
                        if(val.isEmpty){return "Please fill in your Name";}
                        if(val.length>10){return "Second Name length can't exceed 10 characters";}
                        return null;
                      },
                    ),
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
          onPressed: ()
          {
            final form= formKey.currentState;
            if(form.validate())
            {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>TermsPage()));
            }
          },

          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }
}
