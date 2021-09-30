import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/firebase_db.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  // var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String UserName;
  String UserNumber;
  File imageFile;
  String _url;
  final ImagePicker picker = ImagePicker();

  @override
  void initState(){
    super.initState();
    retrieve_name();
    loadImage();
  }
  void retrieve_name() async
  {
    try {
      await ref.child(FirebaseAuth.instance.currentUser.uid).once().then((DataSnapshot snapshot) async {
        setState(() {
          UserName = snapshot.value['Name'];
          UserNumber=snapshot.value['Phone'];
          print("=____________++++++++++++++++++++++");
          print(UserNumber);
          print(UserName);
        });
      });
    }
    catch(e)
    { print("you got error: $e");}
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        //  backgroundColor: Colors.red,


        centerTitle: true,

        title: Center(
          child: Text(translate(context,'Edit Profile'),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black,),),


      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height -  MediaQuery.of(context).padding.top ,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 30,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  mainAxisSize: MainAxisSize.max,

                children: [


                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Container(
                          //  color: Colors.grey.shade400,
                          height: MediaQuery.of(context).size.height * 0.15,

                          child: Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                  _url == null
                                      ?   AssetImage(
                                    "assets/images/profile_pic.jpg",
                                  ):
                                  NetworkImage(_url),
                                  minRadius: 43,
                                  maxRadius: 43,
                                ),


                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.5,
                                top: MediaQuery.of(context).size.height * 0.085,

                                child: Container(

                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(
                                        color: Colors.grey.shade400,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: Offset(2,7),
                                      )]
                                  ),

                                  padding: EdgeInsets.all(8),
                                  child:  IconButton(icon: Icon(Icons.edit, color: Colors.black,), onPressed: ()
                                  {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder:((builder)=> bottomsheet()),
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),

                        customTextFormField(
                          hint: UserName,
                          //hint: currentUserInfo.name,
                          label: translate(context,'Name'),
                          textController: nameController,
                          validator:  (value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty.';
                            }
                            return null;
                          },

                          textInputType: TextInputType.name,

                        ),

                        // customTextFormField(
                        //   //TODO: email validator
                        //     label: "Email",
                        //     textController: emailController,
                        //     validator:  (value) {
                        //       if (value.isEmpty) {
                        //         return 'Email must not be empty.';
                        //       }
                        //       return null;
                        //     },
                        //   textInputType: TextInputType.emailAddress,
                        //
                        // ),
                        customTextFormField(
                          hint: UserNumber,
                          label: translate(context,'Phone Number (Registered)'),
                          textController: phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return translate(context,'Phone number must not be empty.');
                            }
                            return null;
                          },
                          textInputType: TextInputType.phone,

                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  customBlackButton(
                      title: translate(context,'Update'),
                      onTap: (){
                        if(formKey.currentState.validate())
                        {
                          // ///TODO: Important: this is a security sensitive operation that
                          // ///requires the user to have recently signed in. If this requirement isn't met,
                          // ///ask the user to authenticate again and later call reauthenticate(AuthCredential).
                          // FirebaseAuth.instance.verifyPhoneNumber(
                          //     phoneNumber: UserNumber,
                          //     timeout: const Duration(minutes: 2),
                          //     verificationCompleted: (credential) async {
                          //        FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);
                          //       // either this occurs or the user needs to manually enter the SMS code
                          //     },
                          //     verificationFailed: null,
                          //     codeSent: (verificationId, [forceResendingToken]) async {
                          //       String smsCode;
                          //       // get the SMS code from the user somehow (probably using a text field)
                          //       final AuthCredential credential =
                          //       PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
                          //       FirebaseAuth.instance.currentUser.updatePhoneNumber(credential);
                          //     },
                          //     codeAutoRetrievalTimeout: null);

                        //  FirebaseAuth.instance.currentUser.updatePhoneNumber(phoneCredential)
                          ref.child(currentUser.uid).update({'Name': nameController.text });
                          // ref.child(currentUser.uid).update({'Phone': phoneController.text });
                          print("updated.");
                        }

                      }),
                ],),),
          ),
        ),
      ) ,);

  }

  Widget bottomsheet()
  {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20
          ,vertical: 20),
      child: Column(
        children: <Widget>[
          Text('Choose Profile Picture',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          SizedBox( height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon( Icons.camera,color: Colors.black,),
                onPressed: (){
                  takephoto(ImageSource.camera);
                  Navigator.pop(context);

                },
                label: Text('Camera',style: TextStyle(color:Colors.black)),
              ),
              FlatButton.icon(
                icon: Icon( Icons.image,color: Colors.black),
                onPressed: (){
                  takephoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text('Gallery',style: TextStyle(color:Colors.black)),
              ),
              FlatButton.icon(
                icon: Icon( Icons.delete,color: Colors.black),
                onPressed: (){
                  deletePhoto();
                  Navigator.pop(context);
                },
                label: Text('Remove',style: TextStyle(color:Colors.black),),
              )

            ],

          )
        ],
      ),
    );
  }
  void takephoto ( ImageSource source) async {

    var PickedFile = await ImagePicker.pickImage(source: source);

    setState(() {
      imageFile = PickedFile;
    });
    uploadImage(context);
  }

  void uploadImage(context) async {

    try {
      ///TODO:Delete the old photo
      StorageReference refr = storage.ref().child('UsersImages').child(currentUser.uid).child(Path.basename(imageFile.path));
      print("##################################");
      print(imageFile);
      print(imageFile.path);
      ref.child(currentUser.uid).child('ProfilePhoto').update({"Path": imageFile.path});

      StorageUploadTask storageUploadTask = refr.putFile(imageFile);
      showDialog(context: context, builder:  ((builder)=> Center(child: CircularProgressIndicator( color: Colors.grey))));
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile photo updated successfully!"),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      setState(() {
        _url = url;
      });
      ref.child(currentUser.uid).child('ProfilePhoto').update({"URL": _url});


    } catch (ex) {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  void loadImage() async {
    String myUrl='';
    try {
      await ref.child( currentUser.uid).child('ProfilePhoto').once().then((DataSnapshot snapshot) async {

        setState(() {
          myUrl = snapshot.value['URL'];
        });
      });
    }
    catch(e)
    { print("you got error: $e");
    _url=null;
    return;
    }

    setState(() {
      _url=myUrl;
      print(_url);
      // imageFile = File(path);
    });
  }
  void deletePhoto() async
  {
    String myPath='';
    if ( _url != null)
    {
      try {
        await ref.child( currentUser.uid).child('ProfilePhoto').once().then((DataSnapshot snapshot) async {
          setState(() {
            myPath = snapshot.value['Path'];
            print("=____________++++++++++++++++++++++");
            print(myPath);
          });
        });
      }
      catch(e)
      { print("you got error: $e");}
      StorageReference refr = storage.ref().child('UsersImages').child(currentUser.uid).child(Path.basename(myPath));
      refr.delete();
      driversRef.child( currentUser.uid).child('ProfilePhoto').remove();
      setState(() {
        _url = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile photo is removed"),
      ));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No photo to remove!"),
      ));
    }
  }
}

