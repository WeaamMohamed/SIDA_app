// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sida_app/shared/utils.dart';
//
//
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample>  with WidgetsBindingObserver{
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//         ///  _controller.complete(controller);
//
//           onMapCreated(controller);
//
//
//         },
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: _goToTheLake,
//       //   label: Text('To the lake!'),
//       //   icon: Icon(Icons.directions_boat),
//       // ),
//     );
//   }
//
//
//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     //_goToTheLake();
//   //     setState(() {
//   //      _kGooglePlex;
//   //      _controller;
//   //     });
//   //   }
//   // }
//   //
//   // Future<void> _initMapStyle() async {
//   //   _mapStyle ??= await rootBundle.loadString(ThemeAssets.mapsStyle);
//   //   await _controller?.setMapStyle(_mapStyle);
//   // }
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
//
//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     switch (state) {
//       case AppLifecycleState.inactive:
//         print('appLifeCycleState inactive');
//         break;
//       case AppLifecycleState.resumed:
//         final GoogleMapController controller = await _controller.future;
//         onMapCreated(controller);
//         print('appLifeCycleState resumed');
//         break;
//       case AppLifecycleState.paused:
//         print('appLifeCycleState paused');
//         break;
//       case AppLifecycleState.detached:
//         print('appLifeCycleState detached');
//         break;
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   //onMapCreated method
//   void onMapCreated(GoogleMapController controller) {
//   //  controller.setMapStyle('[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');
//       controller.setMapStyle(Utils.mapStyles);
//     _controller.complete(controller);
//   }
//
//
// }



//todo; waiting time ;


//todo: when driver accept .. stop timeout and delete from rideReques