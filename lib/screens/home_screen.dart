import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/models/direction_details_model.dart';
import 'package:sida_app/screens/where_to_screen.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/widgets/home_drawer.dart';
import 'package:sida_app/widgets/select_and_confirm_ride.dart';
import 'package:sida_app/shared/network/remote/assistantMethods.dart';
import 'package:sida_app/shared/network/remote/requestAssistant.dart';

import '../shared/network/remote/assistantMethods.dart';
import '../shared/network/remote/requestAssistant.dart';

import 'package:sida_app/shared/data_handler/data_provider.dart';
//TODO: convert to stateles
class HomeScreen extends StatefulWidget {
  final String userID;
  HomeScreen(  this.userID,{Key key}):super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // List<LatLng> pLineCoordinates = [];
  // Set<Polyline> polylineSet = {};

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  // GoogleMapController newGoogleMapController;


  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 14.4746,
  );

  Position _userCurrentPosition;

  final double mainHorizontalMargin = 15.0;

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    Size mqSize = MediaQuery.of(context).size;



    void locatePosition() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _userCurrentPosition = position;

      LatLng userLatLangPosition = LatLng(
        position.latitude,
        position.longitude,
      );

      CameraPosition cameraPosition =
      new CameraPosition(target: userLatLangPosition, zoom: 17);

      mapProvider.newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));



      //to get user's current address
      String currentUserAddress =
      await RequestAssistant.getSearchCoordinateAddress(position: position, context: context);
      print("this is your address: " + currentUserAddress);
    }

    // final CameraPosition _kGooglePlex = CameraPosition(
    //   target: LatLng(37.42796133580664, -122.085749655962),
    //   zoom: 14.4746,
    // );

    //#FED444 - #FEBA3F
    return Scaffold(
      key: scaffoldKey,

      drawer: HomeDrawer(),
      body: SingleChildScrollView(


        child: Container(

          height: MediaQuery.of(context).size.height,
          width: mqSize.width,

          child: Stack(
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
                tiltGesturesEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: false,
                polylines: mapProvider.polylineSet,
                // markers: markersSet,
                // circles: circlesSet,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  mapProvider.newGoogleMapController = controller;
                  locatePosition();

                  //  locatePosition();
                },
              ),

              //for shadow
              _buildShadow(),

              //menu button
              _buildMenuButton(),

              if(dataProvider.homeStatus == HomeStatus.INITIAL) Positioned(
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
                          mapProvider.userPickUpLocation != null?
                          mapProvider.userPickUpLocation.placeName:
                          "Loading Pickup address...",

                          // "El-Tahrir Square, Qasr El N aaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa",
                          withIcon: true,
                          //    onTap: () {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        customHomeButton(
                            context: context,
                            title: "Set pickup location",
                            onTap: () {

                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => WhereToScreen(),),
                              );


                            }),
                      ],
                    )

                ),
              ),



              if(dataProvider.homeStatus == HomeStatus.SELECT_AND_CONFIRM_RIDE)Positioned(
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

                ),
              ),


              //for shadow
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {

    AssistantMethods.getCurrentOnlineUserInfo();

    // TODO: implement initState
    //to hide app bar and status bar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
          statusBarIconBrightness: Brightness.dark,
        ));
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
        FirebaseAuth.instance.signOut();
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


