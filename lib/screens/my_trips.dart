import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/models/appData.dart';
import 'package:sida_app/models/history.dart';
import 'package:sida_app/screens/trip_details.dart';
import 'package:sida_app/screens/trip_item.dart';
import 'package:sida_app/widgets/home_drawer.dart';

import '../firebase_db.dart';
class MyTrips extends StatefulWidget {

  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {


  String carDetails='';
  ScrollController scrollController =
  ScrollController(); //To Track Scroll of ListView\

  @override
  Widget build(BuildContext context) {

    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 0.09 * screenHeight),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDrawer()));
                    }, icon: Icon(Icons.west)),
                    SizedBox(width: 0.2 * screenWidth),
                    Align(
                      alignment: Alignment.center,
                      child: Text('My Trips',
                          style: TextStyle(
                              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                SizedBox(height: 0.05 * screenHeight),
                ListView.separated(

                  itemBuilder: (context, index)
                  {
                    return TripItem(history:Provider.of<AppData>(context, listen: false).tripHistoryDataList[index] ,);
                      //TripItem(screenWidth,screenHeight, Provider.of<AppData>(context, listen: false).tripHistoryDataList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(thickness: 20.0, height: 40.0,),
                  itemCount: tripCount,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                ),
                // ListView.separated(
                //     separatorBuilder: (BuildContext context, int index) {
                //       return SizedBox(width: 30);
                //     },
                //     itemCount: 52,
                //
                //
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container ( width: 10,
                //       height: 30,
                //       color:Colors.teal);
                //         //TripItem(screenWidth,screenHeight, Provider.of<AppData>(context, listen: false).tripHistoryDataList[index]);
                //     },
                //   ),



              ],
            )
          ],
        ),
      )
    );
  }

}


