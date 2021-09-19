import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/users.dart';
final database =FirebaseDatabase.instance;
final ref = database.reference().child('Users');


User currentUser;
Users currentUserInfo;
