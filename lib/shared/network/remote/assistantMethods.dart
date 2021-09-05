import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sida_app/shared/components/constants.dart';

import '../../../models/direction_details_model.dart';
import 'package:sida_app/models/users_model.dart';

class AssistantMethods{

  // static Future<String> getSearchCoordinateAddress(Position position)async{
  //   String placeAddress = "";
  //   String _url =
  //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$MAP_API_KEY";
  //
  //   dynamic response = RequestAssistant.getRequest(_url);
  //
  //   if(response != "failed")
  //     {
  //
  //       placeAddress = response["results"][0]["formatted_address"];
  //
  //     }
  //   return placeAddress;
  //
  //
  // }




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
}