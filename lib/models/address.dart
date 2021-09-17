import 'package:firebase_auth/firebase_auth.dart';

class Address{
  String placeName = "";
  double latitude;
  double longitude;
  String placeId;
  String placeFormattedAddress;

  Address(
    {
    this.placeFormattedAddress, this.placeName,
    this.placeId, this.latitude, this.longitude
    });

  void f()
  {
    FirebaseAuth.instance.currentUser.uid;
  }

}