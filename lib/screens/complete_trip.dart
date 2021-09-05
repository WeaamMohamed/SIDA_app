import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'promotion_page.dart';

class CompleteTrip extends StatefulWidget {
  @override
  _CompleteTripState createState() => _CompleteTripState();
}

class _CompleteTripState extends State<CompleteTrip> {

  @override
  List<bool> Ispressed = [true,false,false,false,false];
  List<Color> buttons_colors = [Colors.black,HexColor('#FAF2C6').withOpacity(0.35),HexColor('#FAF2C6').withOpacity(0.35),HexColor('#FAF2C6').withOpacity(0.35),HexColor('#FAF2C6').withOpacity(0.35)];


  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              HexColor("#FEBA3F"),
              HexColor("#FED444"),
               ],
             ),),
              child:Column(
                children: [
                  SizedBox(height: 0.05 * screenHeight),
                  Row(
                    children: [
                      IconButton(onPressed: (){ }, icon: Icon(Icons.west)),
                      SizedBox(width: 0.2 * screenWidth),
                      Align(
                        alignment: Alignment.center,
                        child: Text(' Complete Trip',
                            style: TextStyle(
                                color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                  Container(
                    decoration:BoxDecoration(
                        border: Border.all(color:HexColor('#FAF2C6').withOpacity(0.35) ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color:HexColor('#FAF2C6').withOpacity(0.35),
                    ),

                    width: 0.93*screenWidth,
                    height: 0.15* screenHeight,
                  ),
                  SizedBox(height: 0.05 * screenHeight),
                  Container(
                    width: 0.93*screenWidth,
                    height: 0.9* screenHeight,
                    decoration:BoxDecoration(
                      border: Border.all(color:HexColor('#FAF2C6').withOpacity(0.35) ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color:HexColor('#FAF2C6').withOpacity(0.35),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 0.05*0.9* screenHeight),
                          Text('How was your trip?',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 0.05*0.9* screenHeight),
                          Text('Help us improve our services and your',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0 )),
                          Text('experience by rating this trip',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0 )),
                          SizedBox(height: 0.05*0.9* screenHeight),
                          RatingBar.builder(

                            itemCount: 5,
                            initialRating: 0,
                            itemSize: 70,
                            // direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                            onRatingUpdate: (rating)async {
                             // dynamic rater= await  Ratepro(CUSTID, rating,product.id  );
                              print(rating);
                            },
                          ),
                          SizedBox(height: 0.08* screenHeight),
                          Text('Did you added tip?',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.0 )),
                          SizedBox(height: 0.05*screenHeight),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 0.2*screenWidth,
                                  height: 0.11*screenHeight,
                                  child: TextButton(
                                      onPressed: ( ){
                                        setState(() {

                                          buttons_colors[0]= Colors.black;
                                          Ispressed[0]=true;
                                          for(int i=1; i< 5; i++)
                                            {
                                              buttons_colors[i]=HexColor('#FAF2C6').withOpacity(0.35);
                                              Ispressed[i]=false;
                                            }

                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:   MaterialStateProperty.all<Color>(buttons_colors[0]),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide(width:3)
                                              ),

                                          )
                                      ),
                                      child:   Text('No tip',
                                          style: Ispressed[0] ? TextStyle(
                                              color:Colors.white, fontSize: 17.0 ):TextStyle(
                                              color: Colors.black, fontSize: 17.0 ) )
                                  ),
                                ),
                                SizedBox(width: 0.02 *screenWidth),
                                SizedBox(
                                  width: 0.15*screenWidth,
                                  height: 0.11*screenHeight,
                                  child: TextButton(
                                      onPressed: ( ){
                                        setState(() {
                                          Ispressed[1]=true;
                                          buttons_colors[1]= Colors.black;
                                          for(int i=0; i< 5; i++)
                                          {
                                            if(i != 1)
                                              {
                                              buttons_colors[i]=HexColor('#FAF2C6').withOpacity(0.35);
                                              Ispressed[i]=false;
                                              }
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:   MaterialStateProperty.all<Color>(buttons_colors[1]),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide(width:3)
                                              )
                                          )
                                      ),
                                      child:   Text('5 EGP',
                                          style:  Ispressed[1] ? TextStyle(
                                              color:Colors.white, fontSize: 14.0 ):TextStyle(
                                              color: Colors.black, fontSize: 14.0 ) )
                                  ),
                                ),
                                SizedBox(width: 0.02*screenWidth),
                                SizedBox(
                                  width: 0.15*screenWidth,
                                  height: 0.11*screenHeight,
                                  child: TextButton(
                                      onPressed: ( ){
                                        setState(() {
                                          buttons_colors[2]= Colors.black;
                                          Ispressed[2]=true;
                                          for(int i=0; i< 5; i++)
                                          {
                                            if(i != 2)
                                            {
                                            buttons_colors[i]=HexColor('#FAF2C6').withOpacity(0.35);
                                            Ispressed[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:   MaterialStateProperty.all<Color>(buttons_colors[2]),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide(width:3)
                                              )
                                          )
                                      ),
                                      child:   Text('10 EGP',
                                          style: Ispressed[2] ? TextStyle(
                                              color:Colors.white, fontSize: 14.0 ):TextStyle(
                                              color: Colors.black, fontSize: 14.0 ))
                                  ),
                                ),
                                SizedBox(width: 0.02 *screenWidth),
                                SizedBox(
                                  width: 0.15*screenWidth,
                                  height: 0.11*screenHeight,
                                  child: TextButton(
                                      onPressed: ( ){
                                        setState(() {
                                          buttons_colors[3]= Colors.black;
                                          Ispressed[3]=true;
                                          for(int i=0; i< 5; i++)
                                          {
                                            if ( i != 3)
                                             {
                                            buttons_colors[i]=HexColor('#FAF2C6').withOpacity(0.35);
                                            Ispressed[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:   MaterialStateProperty.all<Color>(buttons_colors[3]),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide(width:3)
                                              )
                                          )
                                      ),
                                      child:   Text('15\nEGP',
                                          style:Ispressed[3] ? TextStyle(
                                              color:Colors.white, fontSize: 14.0 ):TextStyle(
                                              color: Colors.black, fontSize: 14.0 ))
                                  ),
                                ),
                                SizedBox(width: 0.02 *screenWidth),
                                SizedBox(
                                  width: 0.15*screenWidth,
                                  height: 0.11*screenHeight,
                                  child: TextButton(
                                      onPressed: ( ){
                                        setState(() {
                                          buttons_colors[4]= Colors.black;
                                         Ispressed[4]=true;
                                          for(int i=0; i< 5; i++)
                                          {
                                            if ( i != 4)
                                              {
                                              buttons_colors[i]=HexColor('#FAF2C6').withOpacity(0.35);
                                              Ispressed[i]=false;
                                              }
                                          }
                                        });
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:   MaterialStateProperty.all<Color>(buttons_colors[4]),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  side: BorderSide( width:3)
                                              )
                                          )
                                      ),
                                      child:   Text('20 EGP',
                                          style: Ispressed[4] ? TextStyle(
                                              color:Colors.white, fontSize: 14.0 ):TextStyle(
                                              color: Colors.black, fontSize: 14.0 ))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.03 *screenHeight),
                          SizedBox(
                            width: 0.8*screenWidth,
                            height: 0.09*screenHeight,
                            child: TextField(
                                decoration: InputDecoration(
                                  labelText:  " Write a comment ...",
                                  labelStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.4),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),

                                )),
                          ),
                          SizedBox(height: 0.03*screenHeight),
                          SizedBox(
                            width: 0.8*screenWidth,
                            height: 0.09*screenHeight,
                            child: TextButton(
                                onPressed: ( ){
                              /// Submit!!!!!!
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) => PromotionPage()));
                                },
                                style: ButtonStyle(
                                  backgroundColor:   MaterialStateProperty.all<Color>(Colors.black),
                                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                    overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide()
                                        )
                                    )
                                ),
                                child:   Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0, fontFamily: 'spoqa_han_sans',fontWeight: FontWeight.bold))
                            ),
                          ),
                          SizedBox(height: 0.05 * screenHeight),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.1 * screenHeight),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
