import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/models/history.dart';
import 'package:sida_app/firebase_db.dart';
import 'package:sida_app/screens/trip_details.dart';

class TripItem extends StatefulWidget {

  final myHistory history;
  TripItem({this.history});

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {

  String carDetails='';

  @override
  void initState() {
     getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(HelperMethods.formatTripDate(widget.history.createdAt )  , style: TextStyle(
                      color: Colors.black, fontSize: 18
                  ),),
                  SizedBox(height: 0.03 * screenHeight),
                  Text(carDetails, style: TextStyle(
                      color:  HexColor("#8D90A1") , fontSize: 18
                  ),),

                ],
              ),
              SizedBox(width: 0.15*screenWidth,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( widget.history.fares +" EGP", style: TextStyle(
                      color: Colors.black, fontSize: 18
                  ),),
                  SizedBox(height: 0.03 * screenHeight),
                  Text( widget.history.paymentMethod, style: TextStyle(
                      color: HexColor("#8D90A1"), fontSize: 18
                  ),)
                ],
              ),

              IconButton(icon: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>TripDetails(history: widget.history,)
                    ),
                  );
                },)
            ],
          ),
        ),


        SizedBox(height: 0.01 * screenHeight),
        Container(
          width: screenWidth,
          height: 0.25 * screenHeight,
          decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash_bg_opacity.png"),
                fit: BoxFit.cover,
              )
          ),
        ),

      ],
    );
  }
  void getData() async
  {
    try {
      await driversRef.child(widget.history.driverId).child("carDetails").once().then((DataSnapshot snapshot) async {
        setState(() {
          print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          print(widget.history.driverId);
          carDetails = snapshot.value['carBrand']+" "+snapshot.value['carModel'] ;
        });
      });
    }
    catch(e)
    { print("you got error: $e");}
  }
}
