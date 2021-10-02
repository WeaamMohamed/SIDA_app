import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_app/SignUp_SignIn/mobile_phone_page.dart';
import 'package:sida_app/models/animated_toggle_button.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/screens/complete_trip.dart';
import 'package:sida_app/screens/edit_profile_screen.dart';
import 'package:sida_app/screens/my_trips.dart';
import 'package:sida_app/screens/settings_screen.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/network/local/cache_helper.dart';
import 'package:sida_app/shared/styles/colors.dart';

import '../firebase_db.dart';
import '../main.dart';

class HomeDrawer extends StatefulWidget {

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

 String name='';
  String _url;

  @override
  void initState() {
    super.initState();
    getData();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [customAmberColor1, customAmberColor2],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                //offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell( child:
              CircleAvatar(
                      backgroundImage:
                      _url == null
                          ?     AssetImage(
                  "assets/images/profile_pic.jpg",
                ):
                      NetworkImage(_url),

                minRadius: 43,
                maxRadius: 43,
              ),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfileScreen(),),),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              //TODO: Weaam Re-position this button >>
              Container(padding: EdgeInsets.all(10),
                child: AnimatedToggle(
                  values: ['EN','AR'],
                  onToggleCallback: (index) {

                  print("home index " + index.toString());

                  if(index)
                  {
                    MyApp.setLocale(context, Locale('en', 'US'));
                  }
                  else
                  {
                    MyApp.setLocale(context, Locale('ar', 'EG'));
                  }
                },
              ),
            ),
            ],
          ),
        ),
              //TODO: To there <<
        _buildDrawerItem(
            title: translate(context,'My Trips'),
            imagePath: "assets/images/svg_icon.svg",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>MyTrips()

                ),
              );

            }),
        _buildDrawerItem(
            title: translate(context,'Promotions'),
            imagePath: "assets/images/promotion.svg",
            onTap: () {}),
        _buildDrawerItem(
          title: translate(context,'Help Center'),
          imagePath: "assets/images/call-center-agent.svg",
          onTap: () {},
        ),
        _buildDrawerItem(
            title: translate(context,'Settings'),
            imagePath: "assets/images/settings.svg",
            onTap: () {
              print("settings clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>EditProfileScreen()
                      ///CompleteTrip( driverId: "FANyhIgsIoNsMJN8g0gTv5cqc6Z2",rideId: "-Mkemv3Nt9MIqdLRBZaw",),
                ),
              );
            }),


        _buildDrawerItem(
            ///title: translate(context,'Settings'),
           title: 'log out',
            imagePath: "assets/images/settins.svg",
            onTap: () {
              print("settings clicked");
              FirebaseAuth.instance.signOut().then((value){
                CacheHelper.saveData(key: IS_SIGNED_IN_SHARED_PREF, data: false);
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>PhoneNumberPage(),
                  ///CompleteTrip( driverId: "FANyhIgsIoNsMJN8g0gTv5cqc6Z2",rideId: "-Mkemv3Nt9MIqdLRBZaw",),
                ),
              );
            }),
      ],
    ));
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

 void getData() async
 {
   //TODO:GET BALANCE,PROFIT....
   try {
     await ref.child(  currentUserInfo.id).once().then((DataSnapshot snapshot) async {
       setState(() {
         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         name = snapshot.value['Name'] ;
         print(name);
         print( currentUser.uid);
       });
     });
   }
   catch(e)
   { print("you got error: $e");}

 }

}

Widget _buildDrawerItem({
  String imagePath,
  String title,
  Function onTap,
}) =>
    Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                width: 30,

                height: 30,

                margin:
                    EdgeInsets.only(left: 10, top: 20, bottom: 15, right: 20),

                // child: Icon(Icons.mark_as_unread,),

                child: SvgPicture.asset(imagePath),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        Container(
          //  width: 30,

          padding: EdgeInsets.only(left: 60),

          child: Divider(
            thickness: 2,
            color: Color(0xffE5E5E5),
          ),
        )
      ],
    );
