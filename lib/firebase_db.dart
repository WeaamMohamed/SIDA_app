import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'models/users.dart';
final database =FirebaseDatabase.instance;
final ref = database.reference().child('Users');
final driversRef = database.reference().child('Drivers');
DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("rideRequests");

//todo; use this variables to update ui
String statusRide ='driver is coming';
String carDetailsDriver ='';
String driverName ='';
String driverphone ='';

FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://sida-51cb9.appspot.com');
User currentUser;
Users currentUserInfo;

const String serverToken = 'key=AAAAliK30Io:APA91bHJtvyyOP1ZJC0zTlvkwWUoR6heaxQvErYYj9-Ef7ervqZzNuSnWTX66H_qRW4JQmU3BBm38sXR_4gjBB4FX9791n5UCUdB7ewKrQ-fyy_wtisYF4MiNi6nZDB0AyzqI-UT0ELt';


int driverRequestTimeOut = 40;