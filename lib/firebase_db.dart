import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/users.dart';
final database =FirebaseDatabase.instance;
final ref = database.reference().child('Users');
final driversRef = database.reference().child('Drivers');
DatabaseReference rideRequestRef = FirebaseDatabase.instance.reference().child("rideRequests");

User currentUser;
Users currentUserInfo;

const String serverToken = 'key=AAAAliK30Io:APA91bHJtvyyOP1ZJC0zTlvkwWUoR6heaxQvErYYj9-Ef7ervqZzNuSnWTX66H_qRW4JQmU3BBm38sXR_4gjBB4FX9791n5UCUdB7ewKrQ-fyy_wtisYF4MiNi6nZDB0AyzqI-UT0ELt';


int driverRequestTimeOut = 40;