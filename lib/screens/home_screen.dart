import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_app/widgets/home_drawer.dart';
import 'package:sida_app/shared/styles/colors.dart';


class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {

    Completer<GoogleMapController> _controllerGoogleMap = Completer();
    Position _userCurrentPosition;

    GoogleMapController newGoogleMapController;

    void locatePosition() async
    {




      //TODO: search for location accuracy
     Position  position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
     _userCurrentPosition = position;
      
     LatLng userLatLangPosition=  LatLng(position.latitude,
         position.longitude,);

     print("WEAAM" + userLatLangPosition.longitude.toString() + userLatLangPosition.latitude.toString());

      CameraPosition cameraPosition = new CameraPosition(target: userLatLangPosition, zoom: 14);

      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));


    }

     final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

     final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    //#FED444 - #FEBA3F
    return Scaffold(
      key: scaffoldKey,
     // backgroundColor: Colors.red,

      drawer: HomeDrawer(),
      body: Stack(

        children: [


          GoogleMap(

            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height /4,
                top: 25.0,
            ),
            mapType: MapType.normal,

            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            // polylines: polylineSet,
            // markers: markersSet,
            // circles: circlesSet,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
               locatePosition();



            //  locatePosition();
            },
          ),

          //for shadow
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height /4,
              decoration: BoxDecoration(
                // gradient: LinearGradient(colors: [
                //   Colors.black.withOpacity(0.1),
                //   Color(0xff515151).withOpacity(0.2)
                // ]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.1),
                    spreadRadius: 7,
                    blurRadius: 20,
                    //offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
            ),
          ),

          //menu button
          Positioned(
            top: 35,
            left: 22,
            child: ElevatedButton(
            onPressed: () {

              scaffoldKey.currentState.openDrawer();

            },
           // child: Icon(Icons.menu, color: Colors.black,),
              child: SvgPicture.asset("assets/images/menu_icon.svg"),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              backgroundColor: MaterialStateProperty.all(Colors.white), // <-- Button color
              // overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
              //   if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
              // }),
            ),
          ),),





          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(



               height: MediaQuery.of(context).size.height /4,
             margin: EdgeInsets.symmetric(horizontal: 15,
              vertical: 10,
             ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient:  LinearGradient(
                        colors: <Color>[customAmberColor1, customAmberColor2],
                      ), boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0.0, 2),
                        blurRadius: 7,
                        spreadRadius:1.2,
                      ),
                    ],),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                child: SvgPicture.asset("assets/images/Pickup_Flag.svg"),


                              ),
                              Center(
                                child: Text("El-Tahrir Square, Qasr El N...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.3),
                                    // color:  Color(0xfff707070),
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ),
                            ],
                          )),
                    ),),

                  SizedBox(height: 20,),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient:  LinearGradient(
            colors: <Color>[customAmberColor1, customAmberColor2],
          ),  boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 2),
              blurRadius: 7,
              spreadRadius:1.2,
            ),
          ],),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: (){},
                child: Center(
                  child: Text("Set pickup location",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                )),
          ),),

                ],
              ),
            ),

          ),

          //for shadow


        ],

      ),
    );
  }




  @override
  void initState() {
    // TODO: implement initState
    //to hide app bar and status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.white.withOpacity(0.0) ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

}

