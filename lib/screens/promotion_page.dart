import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'driver_arrived_page.dart';
class PromotionPage extends StatefulWidget {
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
           Column(
             children: [
               SizedBox(height: 0.05 * screenHeight),
               Row(
                 children: [
                   IconButton(onPressed: (){ }, icon: Icon(Icons.west)),
                   SizedBox(width: 0.2 * screenWidth),

                   Align(
                     alignment: Alignment.center,
                     child: Text('Promotion',
                         style: TextStyle(
                             color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.bold)),
                   ),
                 ],
               ),
               SizedBox(height: 0.05 * screenHeight),
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('    Challenges',
                     style: TextStyle(
                         color: Colors.black, fontSize: 25.0 )),
               ),
               SizedBox(height: 0.05 * screenHeight),
               SizedBox(height: 1,width:screenWidth-50, child: Container( color: Colors.grey,),),
               SizedBox(height: 0.05 * screenHeight),
               Container(
                 width: 0.93*screenWidth,
                 height: 0.22* screenHeight,
                 decoration:BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                     colors: [
                       Colors.black,
                       HexColor("#1D1D1D"),
                       HexColor("#545454"),
                     ],
                   ),
                   border: Border.all(color:HexColor('#FAF2C6').withOpacity(0.35) ),
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 0.01 * screenHeight),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         children: [
                           SizedBox(width: 0.07 * screenWidth),
                           Text('SIDA Trips Coin',
                           textDirection: TextDirection.ltr,
                           style: TextStyle(
                               color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ),
                     Row(
                       children: [
                         SizedBox(width: 0.07 * screenWidth),
                         Text('SIDA',
                             style: TextStyle(
                                 color: HexColor('#FFBB00'), fontSize: 50.0, )),
                         SizedBox(width: 0.04 * screenWidth),
                         ///TODO: change it to the real amount of money
                         Text('0.00',
                             style: TextStyle(
                               color: HexColor('#FFBB00'), fontSize: 50.0, )),
                         SizedBox(width: 0.09 * screenWidth),
                         SvgPicture.asset("assets/Coin.svg",width: 65,height: 65)

                       ],
                     )
                   ],
                 ),
               ),
               SizedBox(height: 0.02* screenHeight),
               Text('*1.00 SIDA = 1 Free AnySIDA trip up to 35 EGP !',
                   style: TextStyle(
                       color: Colors.grey, fontSize: 16.0 )),
               SizedBox(height: 0.05* screenHeight),
              Image.asset('assets/challenges.png',width: screenWidth,),
               SizedBox(height: 0.02* screenHeight),
               Text('*Make your every six trips to get 1 FREE trip up to 35 EGP !',
                   style: TextStyle(
                       color: Colors.grey, fontSize: 15.0 )),
               SizedBox(height: 0.07* screenHeight),
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('   Quality & Saving Packs',
                     style: TextStyle(
                         color: Colors.black, fontSize: 25.0 )),
               ),
               SizedBox(height: 0.03 * screenHeight),
               SizedBox(height: 1,width:screenWidth-50, child: Container( color: Colors.grey,),),
               SizedBox(height: 0.05 * screenHeight),
              /// box of the first offer
               Container(
                 width: 0.93*screenWidth,
                 height: 0.56* screenHeight,
                 decoration:BoxDecoration(
                   color: Colors.black.withOpacity(0.80),
                   border: Border.all(color:HexColor('#FAF2C6').withOpacity(0.35) ),
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                 ),
                 child: Column(
                   children: [
                     SizedBox(height: 0.05* screenHeight),
                     Flexible(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(width: 0.07 * screenWidth),
                           Text('AnySIDA discount 20%',
                               style: TextStyle(
                                 color: Colors.white, fontSize: 22.0,fontWeight: FontWeight.bold )),
                           SizedBox(width: 0.03* screenWidth),

                          Image.asset("assets/offer1.png",width: 90,height: 90)
                         ],
                       ),
                     ),
                     SizedBox(height: 0.01* screenHeight),
                     Text('_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ',
                         style: TextStyle(
                             color: Colors.white, fontSize: 20.0)),
                     SizedBox(height: 0.03 * screenHeight),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(width: 0.02 * screenWidth),
                         SvgPicture.asset("assets/checked.svg",width: 25,height: 25),
                         SizedBox(width: 0.03 * screenWidth),
                         Flexible(
                           child: Text('Designed especially for women who go\n to work-home everyday frequently',
                               style: TextStyle(
                                   color: Colors.white, fontSize: 18.0 )),
                         ),
                       ],
                     ),
                     SizedBox(height: 0.03 * screenHeight),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(width: 0.02 * screenWidth),
                         SvgPicture.asset("assets/checked.svg",width: 25,height: 25),
                         SizedBox(width: 0.03 * screenWidth),
                         Flexible(
                           child: Text('Save up to 500 (30 days)',
                               style: TextStyle(
                                   color: Colors.white, fontSize: 18.0 )),
                         ),
                       ],
                     ),
                     SizedBox(height: 0.05 * screenHeight),
                     SizedBox(
                       width: 0.85*screenWidth,
                       height: 0.09*screenHeight,
                       child: TextButton(
                           onPressed: ( ){
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (BuildContext context) => DriverArrived()));

                           },
                           style: ButtonStyle(
                               backgroundColor:   MaterialStateProperty.all<Color>(HexColor('#FFBB00')),
                               padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                               overlayColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                               foregroundColor: MaterialStateProperty.all<Color>(HexColor('#FFBB00')),
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(12.0),
                                       side: BorderSide()
                                   )
                               )
                           ),
                           child:   Text('Buy this pack with 2500EGP',
                               style: TextStyle(
                                   color: Colors.black, fontSize: 18.0, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold))
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 0.05 * screenHeight),
               /// box of the second offer
               Container(
                 width: 0.93*screenWidth,
                 height: 0.56* screenHeight,
                 decoration:BoxDecoration(
                   color: Colors.black.withOpacity(0.80),
                   border: Border.all(color:HexColor('#FAF2C6').withOpacity(0.35) ),
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                 ),
                 child: Column(
                   children: [
                     SizedBox(height: 0.05* screenHeight),
                     Flexible(
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(width: 0.07 * screenWidth),
                           Text('SIDA Kids School Service',
                               style: TextStyle(
                                   color: Colors.white, fontSize: 22.0,fontWeight: FontWeight.bold )),
                           SizedBox(width: 0.02 * screenWidth),
                           Image.asset("assets/offer1.png",width: 50,height: 50 ,)
                         ],
                       ),
                     ),
                     SizedBox(height: 0.01* screenHeight),
                     Text('_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ',
                         style: TextStyle(
                             color: Colors.white, fontSize: 20.0)),
                     SizedBox(height: 0.03 * screenHeight),
                     /// offer description
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(width: 0.02 * screenWidth),
                         SvgPicture.asset("assets/checked.svg",width: 25,height: 25),
                         SizedBox(width: 0.03 * screenWidth),
                         Flexible(
                           child: Text('Full safety and quality service designed\nespecially for families living at the same\narea who wanted to bring their children to/from school every day, at the morning',
                               style: TextStyle(
                                   color: Colors.white, fontSize: 18.0 )),
                         ),
                       ],
                     ),
                     SizedBox(height: 0.05* screenHeight),
                     /// Buy button
                     SizedBox(
                       width: 0.85*screenWidth,
                       height: 0.09*screenHeight,
                       child: TextButton(
                           onPressed: ( ){
                           },
                           style: ButtonStyle(
                               backgroundColor:   MaterialStateProperty.all<Color>(HexColor('#FFBB00')),
                               padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                               overlayColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                               foregroundColor: MaterialStateProperty.all<Color>(HexColor('#FFBB00')),
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                   RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(12.0),
                                       side: BorderSide()
                                   )
                               )
                           ),
                           child:   Text('Buy this pack with 2000EGP',
                               style: TextStyle(
                                   color: Colors.black, fontSize: 20.0, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold))
                       ),
                     ),
                   ],
                 ),
               ),



             ],
           )
          ],
        ),
      ),
    );
  }
}
