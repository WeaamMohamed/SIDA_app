import 'package:firebase_database/firebase_database.dart';

class myHistory
{
  String paymentMethod ='';
  String createdAt='';
  String status='';
  String fares='';
  String dropOff='';
  String pickup='';
 String driverId='';
 String tripID='';
  myHistory({this.paymentMethod, this.createdAt, this.status, this.fares, this.dropOff, this.pickup, this.driverId, this.tripID});

  myHistory.fromSnapshot(DataSnapshot snapshot,key)
  {
    tripID=key.toString();
    paymentMethod = snapshot.value["payment_method"];
    createdAt = snapshot.value["created_at"];
    status = snapshot.value["status"];
    fares = snapshot.value["fare"];
    dropOff = snapshot.value["dropoff_address"];
    pickup = snapshot.value["pickup_address"];
    driverId = snapshot.value["driver_id"];

  }
}