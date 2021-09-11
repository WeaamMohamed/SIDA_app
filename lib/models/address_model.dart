import 'package:firebase_auth/firebase_auth.dart';

class AddressModel{
  String placeFormattedAddress;
  String placeName;
  String placeId;
  double latitude;
  double longitude;

  AddressModel({this.placeFormattedAddress, this.placeName,
    this.placeId, this.latitude, this.longitude});

  void f(){
    FirebaseAuth.instance.currentUser.uid;

  }

}