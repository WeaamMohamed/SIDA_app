import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/helpers/geofirehelper.dart';
import 'package:sida_app/models/direction_details.dart';
import 'package:sida_app/models/nearby_available_drivers.dart';
import 'package:sida_app/screens/driver_arriving.dart';
import 'package:sida_app/screens/finding_a_ride.dart';
import 'package:sida_app/screens/where_to_screen.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/shared/utils.dart';
import 'package:sida_app/widgets/home_drawer.dart';
import 'package:sida_app/widgets/select_and_confirm_ride.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/helpers/requesthelper.dart';
import '../helpers/helpermethods.dart';
import '../helpers/requesthelper.dart';

import 'package:sida_app/shared/data_handler/data_provider.dart';
//TODO: convert to stateles
class HomeScreen extends StatefulWidget {

  // final User user = auth.currentUser;
  // final uid = user.uid;
//   String userID =  FirebaseAuth.instance.currentUser.uid;
  // HomeScreen( this.userID);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {


  HomeStatus _homeStatus;
  //String userID;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  Set<Marker> _Markers = {};
  bool nearbyAvailableDriversKeysLoaded = false;
  BitmapDescriptor nearbyIcon;

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.8025, 26.8206),
    zoom: 14.4746,
  );

  Position _userCurrentPosition;

 // Completer<GoogleMapController> _controllerGoogleMap = Completer();

  final double mainHorizontalMargin = 15.0;
  bool _isGPSEnabled = false;

  @override
  Widget build(BuildContext context) {


    createIconMarker();

    final mapProvider = Provider.of<MapProvider>(context);
   // final dataProvider = Provider.of<DataProvider>(context);

    Size mqSize = MediaQuery.of(context).size;

    Future<void> locatePosition() async {
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


      // setState(() {
      //   _kGooglePlex = cameraPosition;
      // });

      //to get user's current address
      String currentUserAddress =
      await RequestHelper.getSearchCoordinateAddress(position: position, context: context);
      print("this is your address: " + currentUserAddress);

    //  startGeofireListener(context: context);
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

           // _isGPSEnabled?
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
                markers: _Markers,
                // circles: circlesSet,
                onMapCreated: (GoogleMapController controller) async{
                  await _controllerGoogleMap.complete(controller);
                  mapProvider.newGoogleMapController = controller;
                  locatePosition().then((value) => startGeofireListener(context: context));

                  // _controllerGoogleMap.complete(controller);
                  // mapProvider.newGoogleMapController = controller;
                  // locatePosition().then((value) => initGeofireListener(context: context));

                  //  locatePosition();
                },
              )
            ,

              //for shadow
              _buildShadow(),

              //menu button
              _buildMenuButton(),

              if(Provider.of<DataProvider>(context).homeStatus == HomeStatus.INITIAL) Positioned(
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


              if(Provider.of<DataProvider>(context).homeStatus == HomeStatus.SELECT_AND_CONFIRM_RIDE )Positioned(
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


              if(Provider.of<DataProvider>(context).homeStatus == HomeStatus.FINDING_RIDE)Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  //  height: MediaQuery.of(context).size.height / 4,
                  margin: EdgeInsets.symmetric(
                    horizontal: mainHorizontalMargin,
                    vertical: mqSize.height * 0.03,
                  ),
                  child: FindingRide(),

                ),
              ),


              //TODO: driver arriving
              if(Provider.of<DataProvider>(context).homeStatus == HomeStatus.DRIVER_ARRIVING)Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: mainHorizontalMargin,
                      vertical: mqSize.height * 0.03,
                    ),
                    child: DriverArriving(),

                  ),
                ),




            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {

    _homeStatus = HomeStatus.INITIAL;
    // final FirebaseAuth auth = FirebaseAuth.instance;
    //
    // final User user = auth.currentUser;
    // final uid = user.uid;
   /// checkLocationServiceInDevice();
    WidgetsBinding.instance.addObserver(this);
    HelperMethods.getCurrentOnlineUserInfo();

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


  Future<void> checkLocationServiceInDevice() async{

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
     // return Future.error('Location services are disabled.');
      print("please open your GPS");


    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
      ///  checkLocationServiceInDevice();
       print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      permission = await Geolocator.requestPermission();
      print("asking requestPermission again");
     // checkLocationServiceInDevice();
      // Permissions are denied forever, handle appropriately.

    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition();
    //
    setState(() {
      _isGPSEnabled = serviceEnabled;
    });



  }



  //onMapCreated method
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);

    _controllerGoogleMap.complete(controller);


    //TODO:



  }
// lifecycle
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        final GoogleMapController controller = await _controllerGoogleMap.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
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

  ///todo:call it at the end of locateposition function
  void startGeofireListener ({@required context})
  {
    var _mapProvider = Provider.of<MapProvider>(context, listen: false);
    Geofire.initialize('availableDrivers');
    //TODO: Check below statement (UserPickup or currentPosition) ++ Change the distance to 10KM (Operating)
    Geofire.queryAtLocation(_mapProvider.userPickUpLocation.latitude, _mapProvider.userPickUpLocation.longitude, 2147483647).listen((map) {
      //print(map);
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:

            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireHelper.nearbyAvailableDriversList.add(nearbyAvailableDrivers);

            if (nearbyAvailableDriversKeysLoaded)
            {
              updateAvailableDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireHelper.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onKeyMoved:
            NearbyAvailableDrivers nearbyAvailableDrivers=NearbyAvailableDrivers();
            nearbyAvailableDrivers.key= map['key'];
            nearbyAvailableDrivers.latitude=map['latitude'];
            nearbyAvailableDrivers.longitude=map['longitude'];
            GeoFireHelper.updateDriverNearByLocation(nearbyAvailableDrivers);
            updateAvailableDriversOnMap();
            break;


          case Geofire.onGeoQueryReady:
            updateAvailableDriversOnMap();
            break;
        }
      }

      //TODO: memory leak
      setState(() {});
    });
  }

  void updateAvailableDriversOnMap()
  {

    //TODO: memory leak
    setState(() {
      _Markers.clear();
    });

    Set<Marker> tMarkers = Set<Marker>();

    for (NearbyAvailableDrivers driver in GeoFireHelper.nearbyAvailableDriversList)
    {
      LatLng driverPosition = LatLng(driver.latitude, driver.longitude);
      Marker thisMarker = Marker(
        markerId: MarkerId('driver${driver.key}'),
        position: driverPosition,
        ///TODO:IF we want to change the color
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        rotation: HelperMethods.generateRandomNumber(360),
      );
      tMarkers.add(thisMarker);
    }
    setState(() {
      _Markers = tMarkers;
    });
  }

 void createIconMarker()
 {
   if ( nearbyIcon == null)
     {
       ImageConfiguration imageConfiguration= createLocalImageConfiguration(context,size:Size(2,2) );
       BitmapDescriptor.fromAssetImage(imageConfiguration, "assets/images/Driver_Car").then((value)
       {
         nearbyIcon=value;
       });
     }
 }
}