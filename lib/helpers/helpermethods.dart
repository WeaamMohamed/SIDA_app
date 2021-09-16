import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/components/constants.dart';
import '../models/direction_details.dart';
import 'package:sida_app/models/users.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';

class HelperMethods{

  static void getCurrentOnlineUserInfo() async
  {
    currentUser = FirebaseAuth.instance.currentUser;
    String userId = currentUser.uid;

    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('Users/$userId');
    userRef.once().then((DataSnapshot dataSnapShot)
    {
      if(dataSnapShot.value != null)
      {
        currentUserInfo = Users.fromSnapShot(dataSnapShot);
        print('my name is ${currentUserInfo.name}');
      }
    });
  }

  static int estimateFares(DirectionDetails directionDetails)
  {
    // per km = 3 ?? EGP,
    // per minute = 1 ?? EGP,
    // base fare = ?? EGP,

    double baseFare = 10;

    //distanceValue is the distance in meters
    double distanceFare = (directionDetails.distanceValue / 1000) * 3.0;

    //durationValue is duration in seconds
    double timeFare = (directionDetails.durationValue / 60) * 1.0;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

  static DatabaseReference rideRequestRef;

  static void createRideRequest({context}){

    rideRequestRef = FirebaseDatabase.instance.reference().child("rideRequests").push();

    var pickUp = Provider.of<MapProvider>(context, listen: false).userPickUpLocation;
    var dropOff = Provider.of<MapProvider>(context, listen: false).userDropOffLocation;

    Map pickUpLocMap =
    {
      "latitude": pickUp.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };

    Map dropOffLocMap =
    {
      "latitude": dropOff.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
    };

    Map rideInfoMap =
    {
      "created_at": DateTime.now().toString(),
      "rider_name": currentUserInfo.name,
      "rider_phone": currentUserInfo.phone,
      "pickup_address": pickUp.placeName,
      "dropoff_address": dropOff.placeName,
      "pickup_location": pickUpLocMap,
      "dropoff_location": dropOffLocMap,
      "payment_method": "cash",
      "driver_id": "waiting",
      //TODO: SAVE RIDE TYPE
      // "ride_type": carRideType,
    };

    rideRequestRef.set(rideInfoMap);


  }


  static void cancelRideRequest(){

    rideRequestRef.remove();
    //TODO: Then set appState to NORMAL

  }

  static double generateRandomNumber(int max)
  {
    var randomGenerator = Random();
    int randInt = randomGenerator.nextInt(max);
    
    return randInt.toDouble();
  }

}