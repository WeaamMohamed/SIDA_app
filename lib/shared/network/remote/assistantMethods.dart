import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/components/constants.dart';

import '../../../models/direction_details_model.dart';
import 'package:sida_app/models/users_model.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';

class AssistantMethods{

  static DatabaseReference rideRequestRef;

  static int calculateFares(DirectionDetails directionDetails)
  {

    //durationValue is duration in seconds
    double timeTraveledFare = (directionDetails.durationValue / 60) * 0.20;

    //distanceValue is the distance in meters
    double distanceTraveledFare = (directionDetails.distanceValue / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distanceTraveledFare;


    return totalFareAmount.truncate();
  }

  static void getCurrentOnlineUserInfo() async
  {
    firebaseUser = FirebaseAuth.instance.currentUser;
    String userId = firebaseUser.uid;
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);

    reference.once().then((DataSnapshot dataSnapShot)
    {
      if(dataSnapShot.value != null)
      {
        userCurrentInfo = UsersModel.fromSnapShot(dataSnapShot);
      }
    });
  }

  static void saveRideRequest({context}){

     rideRequestRef = FirebaseDatabase.instance.reference().child("Ride_Requests").push();

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
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo.name,
      "rider_phone": userCurrentInfo.phone,
      "pickup_address": pickUp.placeName,
      "dropoff_address": dropOff.placeName,
      //TODO: SAVE RIDE TYPE
      // "ride_type": carRideType,
    };

    rideRequestRef.set(rideInfoMap);


  }


  static void cancelRideRequest(){

    rideRequestRef.remove();

  }



}