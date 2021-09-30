import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sida_app/localization/localization_method.dart';


class TripDetails extends StatefulWidget {
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {

  Color HelpColor_Button = HexColor('FFBB00');
  Color ReceiptColor_Button= Colors.black;
  Color HelpColor_Text = HexColor('FFBB00');
  Color ReceiptColor_Text= HexColor('#FFBB00').withOpacity(0.85);

  /// Help = true & receipt = false
  bool Show = true;

  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;
    final DateTime now = DateTime.now();

    Widget profileImage( AssetImage my_image){
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

    Widget ShowHelpOrReceipt( )
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
                        , child: Flexible(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(translate(context,'I lost an item'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )),
                  ),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight*0.08,
                    child: TextButton(
                        onPressed: (){}
                        , child: Flexible(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(translate(context,'I want to send feedback about the driver'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )),
                  ),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight*.08,
                    child: TextButton(
                        onPressed: (){}
                        , child: Flexible(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(translate(context,'My vehicle was not what I expected'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )),
                  ),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight*0.08,
                    child: TextButton(
                        onPressed: (){}
                        , child: Flexible(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(translate(context,'I had a different issue'), style: TextStyle(color: Colors.black, fontSize: 20),)),
                    )),
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
              profileImage(AssetImage("assets/images/SIDAplus.jpg")),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(translate(context,'You rode with '),
                    style: TextStyle(color:HexColor('#8D90A1') , fontSize: 20),),
                ),
              ),
              SizedBox(height: 0.02* screenHeight),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Row(
                  children: [
                    Column( children: [
                      Text( '4.55',
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
                      Text( '00:17:12',
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
                      Text( 'AnySIDA',
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
                          Text( 'EGP 7.00', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                          SizedBox(height: screenHeight*0.05,),
                          Text( 'EGP 10.46', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
                          SizedBox(height: screenHeight*0.05,),
                          Text( 'EGP 5.21', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
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
                          Text( 'EGP 9.07', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
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
                          Text( 'EGP 3.34', style: TextStyle(color: HexColor('#8D90A1') , fontSize: 15) ),
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
                        IconButton(onPressed: (){ }, icon: Icon(Icons.west)),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(DateFormat("dd/MM/yyyy").format(DateTime.now()) +","+ now.hour.toString()+":" + now.minute.toString(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0)),
                        ),
                        SizedBox(width: 0.2 * screenWidth),
                        Text(' 22.00 EGP',
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0 )),
                      ],
                    ),
                    SizedBox(height: 0.01 * screenHeight),
                    Row(
                      children: [
                        Text(' Audi A4 Sport',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 18.0 )),
                        SizedBox(width: 0.4* screenWidth),
                        Text(translate(context,'CASH'),
                            style: TextStyle(
                                color: Colors.grey, fontSize: 18.0 )),

                      ],
                    ),
                    SizedBox(height: 0.05 * screenHeight),
                    Row(
                      children: [
                        SizedBox(width: 0.02 * screenWidth),
                        SvgPicture.asset('assets/images/PickupFlag.svg',width:25,height:25),
                        SizedBox(width: 0.03 * screenWidth),
                        Flexible(
                            child: Text('El-Tahrir Square, Qasr El Nil, Cairo Governorate',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold))
                        )
                      ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    Row(
                      children: [
                        SizedBox(width: 0.02 * screenWidth),
                        SvgPicture.asset('assets/images/TargetFlag.svg',width: 30,height: 30,),
                        SizedBox(width: 0.03 * screenWidth),
                        Flexible(
                          child: Text('Cairo - Al Wosta, Qasr Ad Dobarah, Qasr El Nile Cairo Governorate',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0 ,fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    SizedBox(height: 0.04 * screenHeight),
                    SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: Colors.grey,),),
                    SizedBox(height: 0.03* screenHeight),
                    Row(
                      children: [
                        ///TODO: replace user image,
                        SizedBox(width: 0.12* screenWidth),

                        SizedBox(width: 0.07* screenWidth),
                        Text(translate(context,'You rated '),
                            style: TextStyle(
                                color: Colors.black, fontSize: 22.0 )),
                        SizedBox(width: 0.04* screenWidth),
                        /// SHOW Rate only
                        ///TODO: disable rating!!!
                        RatingBar.builder(
                          tapOnlyMode: false,
                          onRatingUpdate: (rating){},
                          itemCount: 5,
                          initialRating: 0,
                          itemSize: 20,
                          // direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
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
                    ShowHelpOrReceipt(),
                    SizedBox(height: screenHeight*0.2,)
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

