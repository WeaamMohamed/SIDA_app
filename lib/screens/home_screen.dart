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
import 'package:provider/provider.dart';
import 'package:sida_app/helpers/geofirehelper.dart';
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
import '../firebase_db.dart';
import '../helpers/helpermethods.dart';
import '../helpers/requesthelper.dart';

import 'package:sida_app/shared/data_handler/data_provider.dart';
//TODO: convert to stateles
class HomeScreen extends StatefulWidget {

  final HomeStatus homeStatus;
  HomeScreen({this.homeStatus});

  // final User user = auth.currentUser;
  // final uid = user.uid;
//   String userID =  FirebaseAuth.instance.currentUser.uid;
  // HomeScreen( this.userID);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {


 /// HomeStatus _homeStatus = HomeStatus.INITIAL;
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
  List<NearbyAvailableDrivers> availableDriversList;
  String _carType;
  HomeStatus _homeStatus;

  @override
  Widget build(BuildContext context) {
     _carType = Provider.of<DataProvider>(context).carType;
     _homeStatus = Provider.of<DataProvider>(context).homeStatus;

    // if(widget.homeStatus != null)
    //   {
    //     // setState(() {
    //     //   _homeStatus = widget.homeStatus;
    //     // });
    //   }


    createIconMarker();

    final mapProvider = Provider.of<MapProvider>(context);
   // final dataProvider = Provider.of<DataProvider>(context);

    Size mqSize = MediaQuery.of(context).size;



    // final CameraPosition _kGooglePlex = CameraPosition(
    //   target: LatLng(37.42796133580664, -122.085749655962),
    //   zoom: 14.4746,
    // );

    //#FED444 - #FEBA3F
    return ChangeNotifierProvider.value(
      value: DataProvider(),
      child: Scaffold(
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

                (Provider.of<DataProvider>(context).homeStatus == HomeStatus.INITIAL)?
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height / 4,
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                        // vertical: mqSize.height * 0.06,
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
                ): Container(),
              // (_homeStatus == HomeStatus.INITIAL)?
              //   Consumer<DataProvider>(
              //     builder: (context, myModel, child){
              //       return (myModel.homeStatus == HomeStatus.INITIAL)?
              //         Positioned(
              //         bottom: 0,
              //         left: 0,
              //         right: 0,
              //         child: Container(
              //           //  height: MediaQuery.of(context).size.height / 4,
              //             margin: EdgeInsets.symmetric(
              //               horizontal: 15,
              //               vertical: 20,
              //               // vertical: mqSize.height * 0.06,
              //             ),
              //             child:
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 customHomeButton(
              //                   context: context,
              //                   //TODO: add your pick up location
              //                   title:
              //                   mapProvider.userPickUpLocation != null?
              //                   mapProvider.userPickUpLocation.placeName:
              //                   "Loading Pickup address...",
              //
              //                   // "El-Tahrir Square, Qasr El N aaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaa",
              //                   withIcon: true,
              //                   //    onTap: () {},
              //                 ),
              //                 SizedBox(
              //                   height: 20,
              //                 ),
              //                 customHomeButton(
              //                     context: context,
              //                     title: "Set pickup location",
              //                     onTap: () {
              //
              //                       Navigator.of(context).push(
              //                         MaterialPageRoute(builder: (context) => WhereToScreen(),),
              //                       );
              //
              //
              //                     }),
              //               ],
              //             )
              //
              //         ),
              //       ): Container();
              //     }
              //     ),
                    ///: Container(),


                (Provider.of<DataProvider>(context).homeStatus == HomeStatus.SELECT_AND_CONFIRM_RIDE )?
               // (_homeStatus == HomeStatus.SELECT_AND_CONFIRM_RIDE )?
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
                    child: SelectAndConfirmRide(
                      onTap: (){
                        Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.FINDING_RIDE) ;
                        print(HomeStatus.FINDING_RIDE);

                        HelperMethods.createRideRequest(context: context, carType: _carType,);

                        ///

                        setState(() {
                          availableDriversList = [];
                        availableDriversList = GeoFireHelper.nearbyAvailableDriversList;

                        searchNearestDriver();
                        print('availableDriversList length ' + availableDriversList.length.toString());
                        print('availableDriversList length ' + availableDriversList[0].toString());
                       // _homeStatus = HomeStatus.FINDING_RIDE;
                      // print("selectANdConfirm");

                      });


                    },),

                  ),
                ): Container(),

                (Provider.of<DataProvider>(context).homeStatus == HomeStatus.FINDING_RIDE)?
               // (_homeStatus== HomeStatus.FINDING_RIDE)?
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: mainHorizontalMargin,
                      vertical: mqSize.height * 0.03,
                    ),
                    child: FindingRide(onCancel: (){
                      ///Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.INITIAL);

                      setState(() {

                      });

                      cancelRideRequest();
                      //Provider.of<DataProvider>(context).updateHomeStatus(HomeStatus.INITIAL);
                      // setState(() {
                      //   _homeStatus = HomeStatus.INITIAL;
                      // });
                    },
                    onTap: (){
                      // setState(() {
                      //   _homeStatus = HomeStatus.DRIVER_ARRIVING;
                      // });
                    },),

                  ),
                ): Container(),


                //TODO: driver arriving
               (Provider.of<DataProvider>(context).homeStatus == HomeStatus.DRIVER_ARRIVING)?
               // (Provider.of<DataProvider>(context).homeStatus == HomeStatus.DRIVER_ARRIVING)?
                  Positioned(
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
                  ): Container(),




              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {


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

    Provider.of<MapProvider>(context, listen: false).newGoogleMapController
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


  void resetApp()
  {

    var mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.polylineSet.clear();
    mapProvider.markerSet.clear();
    mapProvider.circleSet.clear();
    mapProvider.pLineCoordinates.clear();

    // statusRide = "";
    // driverName = "";
    // driverphone = "";
    // carDetailsDriver = "";
    // rideStatus = "Driver is Coming";
    // driverDetailsContainerHeight = 0.0;
    locatePosition();
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
      height: MediaQuery.of(context).size.height * 0.22,
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

   void cancelRideRequest(){


     print('weaam : cancelRideRequest()');
     Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.INITIAL);
     FirebaseDatabase.instance.reference().child("rideRequests").remove();
     resetApp();


  }


  void searchNearestDriver()
  {
    print("weaam : searchNearestDdriver() is called");
    if(availableDriversList.length == 0)
    {
      cancelRideRequest();
      resetApp();
      noDriverFound();
      print('weaam : there is no drivers available.');
      defaultToast(message: 'there is no drivers available.', state: ToastState.ERROR);

      return;
    }

    var driver = availableDriversList[0];

    print('weaam : driver key' + driver.key);
    driversRef.child(driver.key).child("carDetails").child("ride_type").once().then((DataSnapshot snap) async
    {
      if(await snap.value != null)
      {
        String availableCarType = snap.value.toString();
        if(availableCarType == _carType)
        {

         notifyDriver(driver);
         setState(() {
           availableDriversList.removeAt(0);
         });

        }
        else
        {

          defaultToast(message: _carType +" drivers not available. Try again.", state: ToastState.ERROR);
          print('weaam : $_carType +" drivers not available. Try again.');
          cancelRideRequest();
         // displayToastMessage(carRideType + " drivers not available. Try again.", context);
        }
      }
      else
      {

        defaultToast(message: "No car found. Try again.", state: ToastState.ERROR);
        print('weaam : No car found. Try again.');
        //displayToastMessage(, context);
      }
    });
  }

  void noDriverFound() {
    //todo;
    print('weaam : noDriverFound()');
  }


  void notifyDriver(NearbyAvailableDrivers driver)
  {
//jk

  print('weaam notifyDriver() .. home');

  //this nto working whyyyyyyyyyyyy

  // here is the error
    driversRef.child(driver.key).child("newRide").set(rideRequestRef.key);
    print('weaam : rideRequestRef.key: ' + rideRequestRef.key);

    driversRef.child(driver.key).child("token").once().then((DataSnapshot snap){
      if(snap.value != null)
      {
        String token = snap.value.toString();

        HelperMethods.sendNotificationToDriver(token, context, rideRequestRef.key);
      }
      else
      {
        return;
      }

      const oneSecondPassed = Duration(seconds: 1);
      var timer = Timer.periodic(oneSecondPassed, (timer) {


        //canceled
        //if(state != "requesting")
        //if user cancel trip
        print('_homeStatus $_homeStatus');
        if(_homeStatus != HomeStatus.FINDING_RIDE)
        {
          driversRef.child(driver.key).child("newRide").set("cancelled");
          driversRef.child(driver.key).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();
        }

        driverRequestTimeOut = driverRequestTimeOut - 1;
        defaultToast(message: 'time : $driverRequestTimeOut', state: ToastState.SUCCESSFUL);
        print("time out: " + driverRequestTimeOut.toString());

        //trip accepted
        driversRef.child(driver.key).child("newRide").onValue.listen((event) {
          if(event.snapshot.value.toString() == "accepted")
          {
            driversRef.child(driver.key).child("newRide").onDisconnect();
            driverRequestTimeOut = 40;
            timer.cancel();
            Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.DRIVER_ARRIVING);
          }
        });

        //time out
        if(driverRequestTimeOut == 0)
        {
          driversRef.child(driver.key).child("newRide").set("timeout");
          driversRef.child(driver.key).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();

          print('weaam: time out searching for new driver');
          defaultToast(
            message: ' time out searching for new driver',state: ToastState.WARNING,
          );

          ///kkk

          searchNearestDriver();
        }
      });
    });
  }
}