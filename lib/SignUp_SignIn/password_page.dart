import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Name_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    obscureText: isHidden,
    decoration: InputDecoration(
      hintText: 'Password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      prefixIcon: Icon(Icons.lock),
      suffixIcon: IconButton(
        icon:
        isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        onPressed: togglePasswordVisibility,
      ),
    ),
    keyboardType: TextInputType.visiblePassword,
    autofillHints: [AutofillHints.password],
    onEditingComplete: () => TextInput.finishAutofillContext(),
    validator: (password) => password != null && password.length < 5
        ? 'Enter min. 5 characters'
        : null,
  );

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}

//// main class of the page:
class passWord extends StatefulWidget {
  @override
  _passWordState createState() => _passWordState();
}

class _passWordState extends State<passWord> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    bool showPassword = false;
    final passwordController = TextEditingController();


    @override
    void dispose() {
     // emailController.dispose();
      passwordController.dispose();
      super.dispose();
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
            child: Column(
              children: [
                SizedBox(height: 0.05 * screenHeight),
                Center(
                  child: Text('Enter your password:',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.0, fontFamily: 'spoqa_han_sans')),
                ),
                SizedBox(height: 0.05 * screenHeight),
                ///Password
                PasswordFieldWidget(controller: passwordController),
                SizedBox(height: 20.0,),
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
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>NamePage()));
          },

          child:   Text(' Next',
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, fontFamily: 'spoqa_han_sans')),),
      ),

    );
  }
}
