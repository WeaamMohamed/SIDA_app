import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'any_sida.dart';


class FindingRide extends StatefulWidget {
  @override
  _FindingRideState createState() => _FindingRideState();
}

class _FindingRideState extends State<FindingRide> {
  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.lightGreen,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 0.5 * screenHeight),
                  Row(
                    children: [
                      SizedBox(width: 0.02 * screenWidth),
                      Container(
                        width: 0.45*screenWidth,
                        height: 0.12* screenHeight,
                        decoration:BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.all(Radius.circular(60)),

                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 0.01 * screenWidth),
                            SvgPicture.asset("assets/dollar.svg",width: 40,height: 40),
                            SizedBox(width: 0.05 * screenWidth),
                            Text('22.20\nEGP',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                            SizedBox(width: 0.02 * screenWidth),
                            Column(
                              ///todo: reduce distance between the 2 icons
                              mainAxisAlignment: MainAxisAlignment.values.last,
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(onPressed: ( ){}, icon: Icon(Icons.add_circle, size: 30,)),

                                IconButton(onPressed: ( ){}, icon: Icon(Icons.remove_circle, size: 30,)),

                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 0.08 * screenWidth),
                      Container(
                        width: 0.4*screenWidth,
                        height: 0.09* screenHeight,
                        decoration:BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:Colors.white ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Column(
                            children: [
                              Text('Finding a ride', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                              SizedBox(height: 0.01* screenHeight),
                              Text('Locating your driver..', style: TextStyle(color: Colors.black, fontSize: 14,  ),),
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 0.06* screenHeight),
                  /// white card
                  Container(
                    width: screenWidth*0.9,
                    height: screenHeight*0.25,
                    decoration: BoxDecoration( color:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),),
                    child: Column(
                      children: [

                        SizedBox(height: 0.03* screenHeight),
                        Row(
                          children: [
                            SizedBox(width: 0.02 * screenWidth),
                            SvgPicture.asset('assets/PickupFlag.svg',width:30,height:30),
                            SizedBox(width: 0.03 * screenWidth),
                            Flexible(
                                child: Text('El-Tahrir Square, Qasr El Nil, Cairo Governorate',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0 ))
                            )
                          ],
                        ),
                        SizedBox(height: 0.03* screenHeight),
                        SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
                        SizedBox(height: 0.03* screenHeight),
                        Row(
                          children: [
                            SizedBox(width: 0.02 * screenWidth),
                            SvgPicture.asset('assets/TargetFlag.svg',width: 30,height: 30,),
                            SizedBox(width: 0.03 * screenWidth),
                            Flexible(
                              child: Text('Cairo - Al Wosta, Qasr Ad Dobarah, Qasr El Nile Cairo Governorate',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.03* screenHeight),
                  SizedBox(
                    width: 0.88*screenWidth,
                    height: 0.08*screenHeight,
                    child: TextButton(
                        onPressed: ( ){

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
                          child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold)),
                        )
                    ),
                  ),

                  SizedBox(height: 0.04 * screenHeight),

                ],)
            ],
          ),
        ),
      ),
    );
  }
}
