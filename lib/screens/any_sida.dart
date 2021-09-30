import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'plus_sida.dart';

class AnySIDA extends StatefulWidget {
  @override
  _AnySIDAState createState() => _AnySIDAState();
}

class _AnySIDAState extends State<AnySIDA> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
          children: [
          Column(
            children: [
              SizedBox(height: 0.1*screenHeight,),
              Container(
              width: screenWidth,
              height: 0.9 *screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(700),topLeft: Radius.circular(700)
                ),
                border: Border.all(
                  color: Colors.green,
                  style: BorderStyle.solid,
                ),
              ),
                child: Column(
                  children: [
                    SizedBox(height: 0.08* screenHeight),
                    Image.asset('assets/anySIDA.jpg'),
                    SizedBox(height: 0.01* screenHeight),
                    Text('AnySIDA',
                        style: TextStyle(
                            color: Colors.black, fontSize: 35 ,fontWeight: FontWeight.bold)),
                    SizedBox(height: 0.02* screenHeight),
                    Flexible(
                      child: Text(translate(context,'For frequent comfortable city trips'),
                          style: TextStyle(
                              color: Colors.black, fontSize: 15)),
                    ),
                    SizedBox(height: 0.04* screenHeight),
                    SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                    SizedBox(height: 0.03* screenHeight),
                 SingleChildScrollView(
                   child: Column(
                     children: [
                       Row(
                         children: [
                           SizedBox(width: 0.05* screenWidth),
                           SvgPicture.asset('assets/like.svg',width: 30,height: 30,),
                           SizedBox(width: 0.07 * screenWidth),
                           Flexible(
                             child: Text('Drivers are selected to be friendly,\nrespectful and polite.',
                                 style: TextStyle(
                                     color: Colors.black, fontSize: 16.0)),
                           )
                         ],
                       ),
                       SizedBox(height: 0.04* screenHeight),
                       SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                       SizedBox(height: 0.03* screenHeight),
                       Row(
                         children: [
                           SizedBox(width: 0.05* screenWidth),
                           SvgPicture.asset('assets/steering-wheel.svg',width: 30,height: 30,),
                           SizedBox(width: 0.07 * screenWidth),
                           Flexible(
                             child: Text(translate(context,'Quality standards have been raised.'),
                                 style: TextStyle(
                                     color: Colors.black, fontSize: 16.0)),
                           )
                         ],
                       ),
                       SizedBox(height: 0.04* screenHeight),
                       SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                       SizedBox(height: 0.02* screenHeight),
                       Row(
                         children: [
                           SizedBox(width: 0.05* screenWidth),
                           SvgPicture.asset('assets/comfortable.svg',width: 30,height: 30,),
                           SizedBox(width: 0.07 * screenWidth),
                           Flexible(
                             child: Text('Additional control over the cleanlin-\ness of the cabin, air conditioner and\nenvironment to provide comfortable\ntrip.',
                                 style: TextStyle(
                                     color: Colors.black, fontSize: 16.0)),
                           )
                         ],
                       ),
                       SizedBox(height: 0.006* screenHeight),
                       Center(
                         child: Row(
                           children: [
                             SizedBox(width: 0.35* screenWidth),
                             IconButton(onPressed: ( ) {}, icon: Icon(Icons.circle, color: Colors.black,size: 15,)),
                             SizedBox(width: 0.02* screenWidth),
                             IconButton(onPressed: ( ) {
                               /// plus SIDA
                               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> PlusSIDA()));
                             }, icon: Icon(Icons.circle, color: Colors.grey,size: 15,)),
                           ],
                         ),
                       ),
                        SizedBox(height: 0.02* screenHeight),
                        SizedBox(
                         width: 0.88*screenWidth,
                         height: 0.07*screenHeight,
                         child: TextButton(
                             onPressed: ( ){
                               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> PlusSIDA()));
                             },
                             style: ButtonStyle(
                                 backgroundColor:   MaterialStateProperty.all<Color>(Colors.black),
                                 padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                 overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                 foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10.0),
                                         side: BorderSide()
                                     )
                                 )
                             ),
                             child:   Align(
                               alignment: Alignment.center,
                               child: Text(translate(context,'Close'),
                                   style: TextStyle(
                                       color: Colors.white, fontSize: 18, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold)),
                             )
                         ),
                       ),

                     ],
                   ),
                 )
                  ],
                ),
              ),
            ],
          ),
          ],
          ),
    );
  }
}
