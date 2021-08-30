import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/widgets/home_drawer.dart';
import 'package:sida_app/widgets/select_and_confirm_ride.dart';

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

    Size mqSize = MediaQuery.of(context).size;
    GoogleMapController newGoogleMapController;
    double mainHorizontalMargin = 15.0;

    void locatePosition() async {
      //TODO: search for location accuracy
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _userCurrentPosition = position;

      LatLng userLatLangPosition = LatLng(
        position.latitude,
        position.longitude,
      );

      CameraPosition cameraPosition =
          new CameraPosition(target: userLatLangPosition, zoom: 14);

      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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
              bottom: mqSize.height / 4,
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
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locatePosition();

              //  locatePosition();
            },
          ),

          //for shadow
           _buildShadow(),

          //menu button
          _buildMenuButton(),

         if(false) Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              //  height: MediaQuery.of(context).size.height / 4,
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: mqSize.height * 0.06,
              ),
              child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customHomeButton(
                            context: context,
                            //TODO: add your pick up location
                            title:
                                "El-Tahrir Square, Qasr El N aaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa",
                            withIcon: true,
                            onTap: () {}),
                        SizedBox(
                          height: 20,
                        ),
                        customHomeButton(
                            context: context,
                            title: "Set pickup location",
                            onTap: () {}),
                      ],
                    )

            ),
          ),



          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              //  height: MediaQuery.of(context).size.height / 4,
                margin: EdgeInsets.symmetric(
                  horizontal: mainHorizontalMargin,
                  vertical: mqSize.height * 0.03,
                ),
                child: SelectAndConfirmRide(),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                //
                //     Row(
                //       children: [
                //         Container(
                //           child: Column(
                //             children: [
                //               Text("Trip",
                //               style: TextStyle(
                //                 fontSize: 11,
                //               ),),
                //               Row(
                //                 children: [
                //                   Text("28",
                //                   style: TextStyle(
                //                     fontSize: 15,
                //                     fontWeight: FontWeight.bold,
                //                   ),),
                //                   Text("min",
                //                     style: TextStyle(
                //                       fontSize: 11,
                //                     ),),
                //                 ],
                //               ),
                //             ]
                //
                //           ),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             //shape: BoxShape.circle,
                //             borderRadius: BorderRadius.circular(333),
                //           ),
                //         )
                //
                //       ],
                //     ),
                //     Container(
                //
                //       padding: EdgeInsets.only(
                //         top: mqSize.height * 0.033,
                //         bottom: mqSize.height * 0.01,
                //         left: 15,
                //         right: 15,
                //         // horizontal: 15,
                //         // vertical: mqSize.height * 0.033,
                //       ),
                //       height: mqSize.height /3.2,
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //         borderRadius: customBorderRadius,
                //       ),
                //       child: Column(
                //
                //
                //         children: [
                //           Flexible(
                //             flex: 6,
                //             child: Row(
                //
                //               children: [
                //                 Container(
                //
                //                   decoration: BoxDecoration(
                //                     borderRadius: customBorderRadius,
                //                     color: Color(0xffFFF3D9),
                //                   ),
                //
                //                 width:(mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                 //  width: mqSize.height * 0.11,
                //                  height: (mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                 //  height: 89,
                //
                //                   padding: EdgeInsets.only(
                //                     left: 10,
                //                     right: 5,
                //                     top: 5,
                //                     bottom: 5,
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Image.asset("assets/images/ic_business_active.png",
                //                            height: 24,
                //                           width: 48,),
                //                           Icon(Icons.remove_circle_outline)
                //                         ],
                //                       ),
                //                       Text("AnySIDA"),
                //                       Row(
                //                     //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Text("EGP",
                //                           style: TextStyle(
                //                             fontSize: 10,
                //                           ),),
                //                           SizedBox(width: 5,),
                //                           Text("33.20", style: TextStyle(
                //
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                           ),),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //
                //                   decoration: BoxDecoration(
                //                     borderRadius: customBorderRadius,
                //                    // color: Color(0xffFFF3D9),
                //                   ),
                //                   width:(mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                   //  width: mqSize.height * 0.11,
                //                   height: (mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                   //  height: 89,
                //                   //  height: 89,
                //
                //                   padding: EdgeInsets.only(
                //                     left: 10,
                //                     right: 5,
                //                     top: 5,
                //                     bottom: 5,
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Image.asset("assets/images/ic_business_passive.png",
                //                             height: 24,
                //                             width: 48,),
                //                           Icon(Icons.remove_circle_outline)
                //                         ],
                //                       ),
                //                       Text("AnySIDA"),
                //                       Row(
                //                         //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Text("EGP",
                //                             style: TextStyle(
                //                               fontSize: 10,
                //                             ),),
                //                           SizedBox(width: 5,),
                //                           Text("33.20", style: TextStyle(
                //
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                           ),),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 Container(
                //
                //                   decoration: BoxDecoration(
                //                     borderRadius: customBorderRadius,
                //                  //   color: Color(0xffFFF3D9),
                //                   ),
                //                   // width: mqSize.height * 0.11,
                //                   // height: mqSize.height * 0.11,
                //                   //  height: 89,
                //
                //                   width:(mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                   //  width: mqSize.height * 0.11,
                //                   height: (mqSize.width - (mainHorizontalMargin *2)) /3.8 ,
                //                   //  height: 89,
                //
                //                   padding: EdgeInsets.only(
                //                     left: 10,
                //                     right: 5,
                //                     top: 5,
                //                     bottom: 5,
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Image.asset("assets/images/ic_business_passive.png",
                //                             height: 24,
                //                             width: 48,),
                //                           Icon(Icons.remove_circle_outline)
                //                         ],
                //                       ),
                //                       Text("AnySIDA"),
                //                       Row(
                //                         //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Text("EGP",
                //                             style: TextStyle(
                //                               fontSize: 10,
                //                             ),),
                //                           SizedBox(width: 5,),
                //                           Text("33.20", style: TextStyle(
                //
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                           ),),
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             ),
                //           ),
                //           SizedBox(height: 20,),
                //           Divider(
                //
                //             thickness: 1,
                //             color: Color(0xffE5E5E5),
                //
                //           ),
                //           SizedBox(height: 10,),
                //           Flexible(
                //             flex: 3,
                //             child: Row(
                //
                //                crossAxisAlignment: CrossAxisAlignment.stretch,
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //
                //
                //               children: [
                //                 Container(
                //                   // width: 55,
                //                   // height: 55,
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.center,
                //                     // crossAxisAlignment: CrossAxisAlignment.stretch,
                //                     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                //                     children: [
                //
                //                       SvgPicture.asset("assets/images/dollar.svg"),
                //                       Center(
                //                         child: Text("Cash",
                //                           style: TextStyle(
                //                             fontSize: 14,
                //                           ),),
                //                       ),
                //
                //                     ],
                //                   ),
                //                 ),
                //                 VerticalDivider(
                //                   thickness: 1,
                //                   color: Color(0xffE5E5E5),
                //                 ),
                //
                //
                //
                //                 Container(
                //                   // width: 55,
                //                   // height: 55,
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.center,
                //                     // crossAxisAlignment: CrossAxisAlignment.stretch,
                //                     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                //                     children: [
                //
                //                       SvgPicture.asset("assets/images/dollar.svg"),
                //                       Center(
                //                         child: Text("Cash",
                //                           style: TextStyle(
                //                             fontSize: 14,
                //                           ),),
                //                       ),
                //
                //                     ],
                //                   ),
                //                 ),
                //                 VerticalDivider(
                //                   thickness: 1,
                //                   color: Color(0xffE5E5E5),
                //                 ),
                //                 Container(
                //                   // width: 55,
                //                   // height: 55,
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.center,
                //                     // crossAxisAlignment: CrossAxisAlignment.stretch,
                //                     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                //                     children: [
                //
                //                       SvgPicture.asset("assets/images/dollar.svg"),
                //                       Center(
                //                         child: Text("Cash",
                //                           style: TextStyle(
                //                             fontSize: 14,
                //                           ),),
                //                       ),
                //
                //                     ],
                //                   ),
                //                 ),
                //                 VerticalDivider(
                //                   thickness: 1,
                //                   color: Color(0xffE5E5E5),
                //                 ),
                //                 Container(
                //                   // width: 55,
                //                   // height: 55,
                //                   child: Column(
                //                     // mainAxisAlignment: MainAxisAlignment.center,
                //                     // crossAxisAlignment: CrossAxisAlignment.stretch,
                //                     mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                //                     children: [
                //
                //                       SvgPicture.asset("assets/images/dollar.svg"),
                //                       Center(
                //                         child: Text("Cash",
                //                           style: TextStyle(
                //                             fontSize: 14,
                //                           ),),
                //                       ),
                //
                //                     ],
                //                   ),
                //                 ),
                //
                //
                //                 // Divider(
                //                 //
                //                 //   thickness: 1,
                //                 //   color: Color(0xffE5E5E5),
                //                 // )
                //               ],
                //             ),
                //           ),
                //
                //
                //         ],
                //       ),
                //     ),
                //     SizedBox(height: mqSize.height * 0.02,),
                //     customHomeButton(context: context, title: "Book No",
                //     onTap: (){}),
                //
                //   ],
                // ),

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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0)));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Widget _buildShadow() => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [
            //   Colors.black.withOpacity(0.1),
            //   Color(0xff515151).withOpacity(0.2)
            // ]),
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.17),
                spreadRadius: 10,
                blurRadius: 45,
               // offset: Offset(2, 9), // changes position of shadow
              ),
            ],
          ),
        ),
      );

  Widget _buildMenuButton() => Positioned(
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
            backgroundColor:
                MaterialStateProperty.all(Colors.white), // <-- Button color
            // overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
            //   if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
            // }),
          ),
        ),
      );
}
