import 'dart:ffi';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/models/history.dart';

import '../firebase_db.dart';
import 'complete_trip.dart';
import 'my_trips.dart';


class TripDetails extends StatefulWidget {

  final myHistory history;
  TripDetails({this.history});
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {

  int rating=00;
  String url='';
  String driverName='';
  String driverRatinigs='';
  String carDetails='';
  bool isRated =false;
  String type='';
  String distance='';
  String time='';
  String distanceTraveledFare ='';
  String extraTimeTraveledFare ='';
  String waitingTimeFare ='';
  Color HelpColor_Button = HexColor('FFBB00');
  Color ReceiptColor_Button= Colors.black;
  Color HelpColor_Text = HexColor('FFBB00');
  Color ReceiptColor_Text= HexColor('#FFBB00').withOpacity(0.85);

  @override
  void initState() {
    getData();
    super.initState();
  }


  /// Help = true & receipt = false
  bool Show = true;
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 0.1* screenHeight),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>MyTrips()

                            ),
                          );
                        }, icon: Icon(Icons.west)),
                        SizedBox(width: 0.2 * screenWidth),
                        Align(
                          alignment: Alignment.center,
                          child: Text(translate(context,'Trip Details'),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    ///TODO: replace with location map
                    SizedBox(height: 0.18 * screenHeight),

                    SizedBox(height: 0.04 * screenHeight),
                    Row(
                      children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text( HelperMethods.formatTripDate(widget.history.createdAt ),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0)),
                          ),
                          SizedBox(height: 0.04 * screenHeight),
                          Text(carDetails,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 18.0 )),

                        ],
                      ) ,
                        SizedBox(width: 0.13 * screenWidth),
                        Column(
                          children: [
                            Text(widget.history.fares+' EGP',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0 )),
                            SizedBox(height: 0.04 * screenHeight),
                            ///TODO: I REMOVED TRANSLATE IT CAUSES ERORR!
                            Text( widget.history.paymentMethod,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18.0 )),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 0.05 * screenHeight),

                    Row(
                      children:<Widget> [
                        //SizedBox(width: 0.02 * screenWidth),
                        Expanded(
                            flex: 1,
                            child: SvgPicture.asset('assets/images/PickupFlag.svg',width:25,height:25)),
                        // SizedBox(width: 0.03 * screenWidth),
                        Expanded(
                          flex: 5,
                          child: Text(widget.history.pickup,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                        ),


                      ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: SvgPicture.asset('assets/images/TargetFlag.svg',width: 30,height: 30,)),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children:<Widget> [
                              Text(widget.history.dropOff,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
                    SizedBox(height: 0.03* screenHeight),

                    isRated ?
                    Row(
                      children: [
                        SizedBox(width: 0.03* screenWidth),

                        new   Stack(
                          children: [
                            Align(
                              //alignment:Alignment.centerLeft,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundImage:  url == null
                                      ?     AssetImage(
                                    "assets/images/profile_pic.jpg",
                                  ):
                                  NetworkImage(url),
                                  radius: 35,
                                ),
                              ),
                            ),

                            Positioned(
                              top: 50,
                            //  alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color:Colors.black,
                                ),
                                width: 0.18*screenWidth,
                                height: 0.04* screenHeight,
                                child:  Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(child: Text( driverRatinigs, style: TextStyle(color:Colors.white,fontSize: 16,))),
                                      SizedBox(width: 0.02*screenWidth,),
                                      Icon(Icons.star,color: Colors.amber,size: 20,)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 0.04* screenWidth),
                        Text(translate(context,'You rated ') +driverName,
                            style: TextStyle(
                                color: Colors.black, fontSize: 20.0 )),
                        SizedBox(width: 0.04* screenWidth),
                        /// SHOW Rate only
                        ///TODO: disable rating!!!
                        RatingBar.builder(
                          tapOnlyMode: true,
                          onRatingUpdate: null,
                          itemCount: 5,
                          initialRating: double.parse(rating.toString()),
                          itemSize: 20,
                          // direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ) :
                    Row(
                        children: [
                          Icon( Icons.star_rounded, size: 30,color: Colors.amber,),
                          SizedBox(width: screenWidth*0.02,),
                          Text( "you didn't rate the trip yet", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),),
                          TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>CompleteTrip(driverId: widget.history.driverId, rideId: widget.history.tripID,)
                                ),
                              );
                            }
                            ,
                            ///TODO:TRANSLATE REMOVED
                            child:
                            Text( 'Rate Now?', style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold, fontSize: 18, decoration: TextDecoration.underline),),

                          ),

                        ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    Container(
                      width: screenWidth,
                      height: screenHeight*0.1,
                      color: Colors.black,
                      child: Row(
                        children: [
                          SizedBox(width: screenWidth*0.05,),
                          /// 1- help
                          Container(
                            width: screenWidth *0.3,
                            height: screenHeight*0.1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border(
                                bottom: BorderSide(width: 4, color: HelpColor_Button),
                              ),
                            ),
                            child: RaisedButton(
                                color: Colors.black,
                                onPressed: (){
                                  setState(() {
                                    Show=true;
                                    HelpColor_Button =  HexColor('#FFBB00');
                                    HelpColor_Text=HexColor('#FFBB00');

                                    ReceiptColor_Button= Colors.black;
                                    ReceiptColor_Text=HexColor('#FFBB00').withOpacity(0.85);
                                  });
                                },
                                child: Text(translate(context,'Help'), style:TextStyle(color:HelpColor_Text,fontSize: 18))

                            ),
                          ),
                          SizedBox(width: screenWidth*0.07,),
                          ///2- Receipt
                          Container(
                            width: screenWidth *0.3,
                            height: screenHeight*0.1,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border(
                                bottom: BorderSide(width: 4, color: ReceiptColor_Button,),
                              ),
                            ),
                            child: RaisedButton(
                                color: Colors.black,
                                onPressed: (){
                                  print("here");
                                  setState(() {
                                    Show=false;
                                    ReceiptColor_Button= HexColor('#FFBB00');
                                    ReceiptColor_Text=HexColor('#FFBB00');

                                    HelpColor_Button = Colors.black;
                                    HelpColor_Text=HexColor('#FFBB00').withOpacity(0.85);
                                  });
                                },
                                child: Text(translate(context,'Receipt'), style:TextStyle(color:ReceiptColor_Text, fontSize: 18))

                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 0.02 * screenHeight),
                    ShowHelpOrReceipt( screenHeight,screenWidth),
                    SizedBox(height: screenHeight*0.2,)
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
  void getData() async
  {
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    try {
      await driversRef.child(widget.history.driverId).once().then((DataSnapshot snapshot) async {
        setState(() {
          print(widget.history.driverId);
          carDetails = snapshot.value['carDetails']['carBrand']+" "+snapshot.value['carDetails']['carModel'] ;
          print(carDetails);
          driverName= snapshot.value['FirstName'];
          driverRatinigs=snapshot.value['ratings'];
          print(driverName);
         url=snapshot.value['Photos']['ProfilePhoto']['URL'];
         // print(url);
        });
      });
    }
    catch(e)
    { print("you got error: $e");}

    try {
      print("**************************************************************");
      print(widget.history.tripID);
      await rideRequestRef.child(widget.history.tripID).once().then((DataSnapshot snapshot) async {

        setState(() {
          type=snapshot.value['ride_type'];
          distanceTraveledFare = snapshot.value['fareDetails']['distanceTraveledFare'];
          extraTimeTraveledFare = snapshot.value['fareDetails']['extraTimeTraveledFare'];
          waitingTimeFare = snapshot.value['fareDetails']['waitingTimeFare'];
          distance=snapshot.value['tripDistance'];
          time=snapshot.value['tripTime'];
        });

        if (snapshot.value['Ratings']['rating'] != null)
          {
            print("yessssssssssssssssssssssssssss");
            print(isRated);

            setState(() {
              isRated=true;
              rating = snapshot.value['Ratings']['rating'] ;
            });
            print(isRated);
          }
      });
    }
    catch(e)
    { print("you got error: $e");}
  }

  Widget profileImage(  my_image, screenHeight,screenWidth){
    return Center(
        child: Stack (
            children: <Widget>[
              Container(
                height: screenHeight*0.2,
                child: Padding(
                  padding: const EdgeInsets.only(left:40.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      radius: 63,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                          radius: 60,
                          backgroundImage: my_image
                      ),
                    ),
                  ),
                ),
              ),
            ]
        ));
  }

  Widget ShowHelpOrReceipt( screenHeight,screenWidth)
  {
    /// HELP
    if (Show)
    {
      return Container(
        width: screenWidth,
        height: screenHeight*0.3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left:30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    width: screenWidth,
                    height: screenHeight*0.08,
                    child: TextButton(
                      onPressed: (){}
                      , child:  Align(
                        alignment: Alignment.topLeft,
                        child: Text(translate(context,'I lost an item'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )
                ),
                SizedBox(
                    width: screenWidth,
                    height: screenHeight*0.08,
                    child: TextButton(
                      onPressed: (){}
                      , child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(translate(context,'I want to send feedback about the driver'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight*.08,
                  child: TextButton(
                    onPressed: (){}
                    , child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(translate(context,'My vehicle was not what I expected'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                  ),
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight*0.08,
                  child: TextButton(
                    onPressed: (){}
                    , child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(translate(context,'I had a different issue'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                  ),
                ),
                SizedBox(height: screenHeight*0.1,)
              ],
            ),
          ),
        ),

      );
    }
    /// Receipt
    else
    {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            profileImage(url == null
                ?     AssetImage(
              "assets/images/profile_pic.jpg",
            ):
            NetworkImage(url), screenHeight,screenWidth),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(translate(context,'You rode with ') +driverName,
                  style: TextStyle(color:HexColor('#8D90A1') , fontSize: 20),),
              ),
            ),
            SizedBox(height: 0.02* screenHeight),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Row(
                children: [
                  Column( children: [
                    Text( (double.parse(distance)/1000).toString() ,
                      style: TextStyle(color: Colors.black, fontSize: 20),),
                    SizedBox(height: 0.02* screenHeight),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(translate(context,'Kilometres'),
                          style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15)),
                    ),
                  ],),
                  SizedBox(width: screenWidth*0.03,),
                  SizedBox(height: screenHeight *0.1,width:2, child: Container( color: HexColor('#C2C9D9'),),),
                  SizedBox(width: screenWidth*0.03,),
                  Column( children: [
                    Text( time ,
                      style: TextStyle(color: Colors.black, fontSize: 20),),
                    SizedBox(height: 0.03* screenHeight),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(translate(context,'Trip time'),
                          style: TextStyle(color:HexColor('#8D90A1') , fontSize: 15)),
                    ),
                  ],),
                  SizedBox(width: screenWidth*0.04,),
                  SizedBox(height: screenHeight *0.1,width:2, child: Container( color: HexColor('#C2C9D9'),),),
                  SizedBox(width: screenWidth*0.04,),
                  Column( children: [
                    Text( type,
                      style: TextStyle(color: Colors.black, fontSize: 20),),
                    SizedBox(height: 0.02* screenHeight),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(translate(context,'Car'),
                          style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15)),
                    ),
                  ],),
                ],
              ),
            ),
            SizedBox(height: 0.04* screenHeight),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(translate(context,'Your Fare'),
                  style: TextStyle(color: Colors.black, fontSize: 20),),
              ),
            ),
            SizedBox(height: 0.05* screenHeight),
            SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#C2C9D9'),),),
            SizedBox(height: 0.03* screenHeight),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(translate(context,'Base fare'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(translate(context,'Distance'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(translate(context,'Time'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.4,),
                Padding(
                  padding: const EdgeInsets.only(right:30.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text(  type == 'SIDA PLUS' ? '12 EGP' : '11 EGP' , style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(  distanceTraveledFare +' EGP', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(  extraTimeTraveledFare+ ' EGP', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.05* screenHeight),
            SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#C2C9D9'),),),
            SizedBox(height: 0.03* screenHeight),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(translate(context,'Normal Fare'), style: TextStyle(color: Colors.black , fontSize: 17) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(translate(context,'Surge '), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.35,),
                Padding(
                  padding: const EdgeInsets.only(right:30.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text( 'EGP 22.6', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text( '0.00 EGP', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.05* screenHeight),
            SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#C2C9D9'),),),
            SizedBox(height: 0.03* screenHeight),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(translate(context,'Subtotal'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(translate(context,'Wait Time'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(translate(context,'Rounding'), style: TextStyle(color: HexColor('#8D90A1') , fontSize: 17) )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.33,),
                Padding(
                  padding: const EdgeInsets.only(right:30.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text( 'EGP 31.30', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text(waitingTimeFare +" EGP", style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                        SizedBox(height: screenHeight*0.05,),
                        Text( 'EGP -0.08', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.05* screenHeight),
            SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#C2C9D9'),),),
            SizedBox(height: 0.03* screenHeight),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth*0.4),
                      Text( 'EGP', style: TextStyle(color: Colors.black , fontSize: 25) ),
                      SizedBox(width: screenWidth*0.04),
                      Text( '31.74', style: TextStyle(color: Colors.black , fontSize: 35) ),
                    ],
                  )),
            ),
            SizedBox(height: 0.05* screenHeight),
            SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#C2C9D9'),),),
            SizedBox(height: 0.02* screenHeight),
          ],
        ),

      );
    }
  }
}

