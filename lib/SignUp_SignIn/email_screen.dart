import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sida_app/shared/components/components.dart';


class EmailScreen extends StatefulWidget {

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {

  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body:  Form(
        key: formKey,
        child: Stack(
          children: [



            Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/splash_bg_no_cairo.png"),
                  fit: BoxFit.cover,

                ),
              ),

              // decoration: BoxDecoration(
              //
              // ),
            ),

            Container(
              height: double.infinity,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
              ),

              // decoration: BoxDecoration(
              //
              // ),
            ),

            Container(

              padding: EdgeInsets.all(20),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
//labelText:"label",

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0,),

                      errorStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.red[700],
                      ),
                      labelText: "Email...",
                      labelStyle: TextStyle(
                        fontSize: 13,
                        color: Color(0xffA9ACB6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    cursorColor: Colors.black,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'This field cannot be left empty';

                      return null;
                    },
                  ),

                  customBlackButton(
                      title: "Next",
                      onTap: () async{


                        print("next");
                        print("Email: " + emailController.text);
                        if(formKey.currentState.validate())
                        {
                          print("updated.");

                        }

                      }
                  ),
                ],
              ),

            ),


          ],
        ),
      ),

    );
  }




  @override
  void initState() {
    // TODO: implement initState
    //to hide app bar and status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }
}
