import 'package:firebase_database/firebase_database.dart';

class Users{

  String id;
  String name = "default";
  //String email;
  String phone;

  Users({
    this.id, 
    this.name, 
    //this.email, 
    this.phone});

  Users.fromSnapShot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key;
    name = dataSnapshot.value["Name"];
    //email = dataSnapshot.value["email"];
    phone = dataSnapshot.value["Phone"];

  }

}