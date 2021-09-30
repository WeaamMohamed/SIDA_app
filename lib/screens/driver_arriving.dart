import 'dart:ui';
import 'package:sida_app/firebase_db.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/shared/data_handler/trip_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'any_sida.dart';

import 'finding_a_ride.dart';

class DriverArriving extends StatefulWidget {
  final String arrivalTime;
  final Function onCancel;
  final String driverName;
  final String timeText;
  DriverArriving({this.arrivalTime, this.onCancel, this.driverName, this.timeText});
  @override
  _DriverArrivingState createState() => _DriverArrivingState();
}

class _DriverArrivingState extends State<DriverArriving> {


  final double mainHorizontalMargin = 15.0;

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    Size mqSize = MediaQuery.of(context).size;

    final double sizedBoxHeight =  10;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight * 0.08,
              //   margin: EdgeInsets.all(15),
              padding: EdgeInsets.all( 10),
              // padding: EdgeInsets.symmetric(horizontal: 10),
              // width: 0.35*screenWidth,
              // height: 0.1* screenHeight,
              decoration:BoxDecoration(
                color: Colors.white,
                border: Border.all(color:Colors.white ),
                borderRadius: BorderRadius.all(Radius.circular(60)),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 // SizedBox(width: 0.01 * screenWidth),
                  SvgPicture.asset("assets/images/dollar.svg",width: 35,height: 35),
                 SizedBox(width: 8),
                  //todo; add fare
                  Text('${ Provider.of<TripProvider>(context).fare}\nEGP',
                      style: TextStyle(
                          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
           // SizedBox(width: 0.09 * screenWidth),
            Container(
              width: 0.5*screenWidth,
              height: 0.1* screenHeight,
              decoration:BoxDecoration(
                color: Colors.white,
                border: Border.all(color:Colors.white ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Container(
                      width: 0.16*screenWidth,
                      height: 0.1* screenHeight,
                      decoration:BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color:Colors.black ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child:Align(
                        alignment: Alignment.center,
                        child: Text(' ${widget.arrivalTime}\nMIN',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
                      )),
                  SizedBox(width: 0.03 * screenWidth),
                  Text(widget.timeText,
                      style: TextStyle(
                          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
        SizedBox(height:sizedBoxHeight),
        /// white card
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

          // width: screenWidth*0.9,
          height: screenHeight*0.45,
          decoration: BoxDecoration( color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //  SizedBox(height: 0.17* screenHeight),
              Container(
                child: Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage(
                      'assets/images/profile_pic.jpg'
                    ),
                    radius: 35,),
                    SizedBox(width: 30,),
                    Column(
                      children: [
                        Text( widget.driverName,style: TextStyle(color: Colors.black),),
                        Text(carDetailsDriver,style: TextStyle(color: Colors.black),),
                        Text(driverphone,style: TextStyle(color: Colors.black),),
                      ],
                    ),

                  ],
                ),
              ),
             // SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),

              Divider(color: Colors.grey, thickness: 1,),
              //   SizedBox(height: 0.03* screenHeight),
              Row(
                children: [
                 // SizedBox(width: 0.02 * screenWidth),
                  SvgPicture.asset('assets/images/PickupFlag.svg',width:25,height:25),
                  SizedBox(width: 15),
                  Flexible(
                      child: Text(
                       /// 'El-Tahrir Square, Qasr El Nil, Cairo Governorate',
                        Provider.of<MapProvider>(context).userPickUpLocation.placeName,
                          style: TextStyle(
                              color: Colors.black, fontSize: 16.0,),)
                  )
                ],
              ),
            //  SizedBox(height: 0.03* screenHeight),
            //   SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
            //   SizedBox(height: 0.03* screenHeight),

              Divider(thickness: 1, color: Colors.grey,),
              Row(
                children: [
                //  SizedBox(width: 0.02 * screenWidth),
                  SvgPicture.asset('assets/images/TargetFlag.svg',width: 25,height: 25,),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                        Provider.of<MapProvider>(context).userDropOffLocation.placeName,
                        ///'Cairo - Al Wosta, Qasr Ad Dobarah, Qasr El Nile Cairo Governorate',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: sizedBoxHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           // SizedBox(width: 0.04* screenWidth),
            ///call button
            Container(
              width: screenWidth*0.35,
              height: screenHeight*0.08,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    HexColor("#FEBA3F"),
                    HexColor("#FED444"),
                  ],

                ),
                //   border: Border.all(color:Colors.black ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: ( ){
                      print(driverphone);
                        launch(( 'tel://${driverphone}'));

                    },
                    child: Center(
                      child:  Row(
                        children: [
                          SizedBox(width: 0.06* screenWidth),
                          Icon( Icons.call,color: Colors.black,size: 30,),
                          SizedBox(width: 0.03* screenWidth),
                          Text(translate(context,'Call'),
                              style: TextStyle(
                                color: Colors.black, fontSize: 22.0,)),
                        ],
                      ),
                    )),
              ),
            ),
          //  SizedBox(width: 0.04 * screenWidth),
            /// TEXT button
            Container(
              width: screenWidth*0.35,
              height: screenHeight*0.08,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    HexColor("#FEBA3F"),
                    HexColor("#FED444"),
                  ],

                ),
                //   border: Border.all(color:Colors.black ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: ( ){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) => AnySIDA()));
                    },
                    child: Center(
                      child:  Row(
                        children: [
                          SizedBox(width: 0.06* screenWidth),
                          Icon( Icons.messenger,color: Colors.black,size: 30,),
                          SizedBox(width: 0.03* screenWidth),
                          Text(translate(context,'Text'),
                              style: TextStyle(
                                color: Colors.black, fontSize: 22.0,)),
                        ],
                      ),
                    )),
              ),

            ),
           // SizedBox(width: 0.04 * screenWidth),
            Container(
              width: screenWidth*0.15,
              height: screenHeight*0.08,
              decoration: BoxDecoration(
                color:Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: IconButton(onPressed: ( ){

                widget.onCancel();
                //
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (BuildContext context) => FindingRide())
               // );
              },
                  icon:Icon( Icons.close_sharp ,color: Colors.white,size: 40,)),
            )
          ],
        ),
       // SizedBox(height: 0.04 * screenHeight),

      ],)
    ;
  }
}
