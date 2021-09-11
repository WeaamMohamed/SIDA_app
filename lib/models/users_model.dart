
import 'package:firebase_database/firebase_database.dart';

class UsersModel{

  String id;
  String name;
  String email;
  String phone;

  UsersModel({this.id, this.name, this.email, this.phone});

  UsersModel.fromSnapShot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key;
    name = dataSnapshot.value["Name"];
    //email = dataSnapshot.value["email"];
    phone = dataSnapshot.value["Phonenumber"];

  }

}