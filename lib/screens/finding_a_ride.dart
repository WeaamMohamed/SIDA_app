import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/shared/data_handler/trip_provider.dart';
import 'any_sida.dart';


class FindingRide extends StatefulWidget {
  final Function onCancel;
  final Function onTap;
  FindingRide({this.onCancel, this.onTap});

  @override
  _FindingRideState createState() => _FindingRideState();
}

class _FindingRideState extends State<FindingRide> {
  final double mainHorizontalMargin = 15.0;


  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final double sizedBoxHeight =  screenHeight * 0.016;


    return  Container(

      // color: Colors.lightGreen,
      child: Column(
        children: [
          //SizedBox(height: 0.5 * screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(width: 0.02 * screenWidth),
              Container(
                // width: 0.45*screenWidth,
                // height: 0.12* screenHeight,
             //   margin: EdgeInsets.all(15),

                decoration:BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color:Colors.white ),
                  borderRadius: BorderRadius.all(Radius.circular(60)),


                ),
                child: Container(
                  height: screenHeight * 0.08,
               //   margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    
                    children: [
                      //SizedBox(width: 0.01 * screenWidth),
                      SvgPicture.asset("assets/images/dollar.svg",width: 40,height: 40, color: Colors.black,),
                      SizedBox(width: 8),
                      Text('${ Provider.of<TripProvider>(context).fare}\nEGP',
                          style: TextStyle(
                              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                   //   SizedBox(width: 0.02 * screenWidth),
                  ///    Column(
                      //   ///todo: reduce distance between the 2 icons
                      //   mainAxisAlignment: MainAxisAlignment.values.last,
                      //   //  crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     IconButton(onPressed: ( ){}, icon: Icon(Icons.add_circle, size: 30,)),
                      //
                      //     IconButton(onPressed: ( ){}, icon: Icon(Icons.remove_circle, size: 30,)),
                      //
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              //     SizedBox(width: 0.08 * screenWidth),
              Container(
                  height: screenHeight * 0.08,
                // width: 0.4*screenWidth,
                // height: 0.09* screenHeight,
                  decoration:BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color:Colors.white ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translate(context,'Finding a ride'), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                       // SizedBox(height: 0.01* screenHeight),
                        Text(translate(context,'Locating your driver...'), style: TextStyle(color: Colors.black, fontSize: 14,  ),),
                      ],
                    ),
                  )
              )
            ],
          ),
          //  SizedBox(height: 0.06* screenHeight),
          /// white card
          SizedBox(height: sizedBoxHeight,),
          Container(
            width: double.infinity,
            height: screenHeight*0.25, 
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration( color:Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

               // SizedBox(height: 0.03* screenHeight),
                Row(
                  children: [
                  //  SizedBox(width: 0.02 * screenWidth),
                    SvgPicture.asset("assets/images/Pickup_Flag.svg",width:25,height:25),
                    SizedBox(width: 0.03 * screenWidth),
                    Flexible(
                        child: Text(
                          Provider.of<MapProvider>(context).userPickUpLocation.placeName,
                          ///  'El-Tahrir Square, Qasr El Nil, Cairo Governorate',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16.0 ))
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Divider(color: Colors.grey, thickness: 1,),
                ),
                // SizedBox(height: 0.03* screenHeight),
                // SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
                // SizedBox(height: 0.03* screenHeight),
                Row(
                  children: [
                   // SizedBox(width: 0.02 * screenWidth),
                    SvgPicture.asset('assets/images/Target_Flag.svg',width: 25,height: 25,),
                    SizedBox(width: 0.03 * screenWidth),
                    Flexible(
                      child: Text(
                          ///'Cairo - Al Wosta, Qasr Ad Dobarah, Qasr El Nile Cairo Governorate',
                          Provider.of<MapProvider>(context).userDropOffLocation.placeName,

                          style: TextStyle(
                              color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          ),
         // SizedBox(height: 0.03* screenHeight),
          SizedBox(height: sizedBoxHeight,),
          //TODO: to cancel trip
          customBlackButton(title: translate(context,'Cancel'), onTap: widget.onCancel),

        ],),
    );
  }
}
