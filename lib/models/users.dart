import 'package:firebase_database/firebase_database.dart';

class Users{

  String id;
  String name = "default";
  //String email;
  String Phonenumber;

  Users({
    this.id, 
    this.name, 
    //this.email, 
    this.Phonenumber});

  Users.fromSnapShot(DataSnapshot dataSnapshot)
  {
    id = dataSnapshot.key;
    name = dataSnapshot.value["Name"]?? "error while loading name";
    //email = dataSnapshot.value["email"];
    Phonenumber = dataSnapshot.value["Phonenumber"];

  }

}