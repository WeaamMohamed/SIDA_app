import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_app/shared/styles/colors.dart';

class HomeDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Drawer(
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
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/profile_pic.jpg",
                    ),
                    minRadius: 43,
                    maxRadius: 43,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 5,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Weaam Mohamed", style: TextStyle(
                            fontSize: 20,
                          ),),
                          SizedBox(height: 10,),

                          Row(
                            // mainAxisAlignment: MainAxisAlignment.s,
                            children: [
                              Text("4.3", style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),),
                              SizedBox(width: 4,),
                              Icon(Icons.star, size: 18, color: Colors.black.withOpacity(0.5),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ),


            _buildDrawerItem(
              title: "My Trips",
              imagePath: "assets/images/svg_icon.svg",
            onTap: (){}),

            _buildDrawerItem(
                title: "Promotions",
                imagePath: "assets/images/promotion.svg",
            onTap: (){}),

            _buildDrawerItem(
                title: "Help Center",
                imagePath: "assets/images/call-center-agent.svg",
            onTap: (){},
            ),

            _buildDrawerItem(
                title: "Settings",
                imagePath: "assets/images/settings.svg",
            onTap: (){}),





          ],
        )
    );
  }
}



Widget _buildDrawerItem({
  String imagePath,
  String title,
  Function onTap,

}) =>   Column(

  children: [

    InkWell(
      onTap: onTap,
      child: Row(

        children: [

          Container(

            width: 30,

            height: 30,

            margin: EdgeInsets.only(

                left: 10, top: 20, bottom: 15,

                right: 20

            ),

            // child: Icon(Icons.mark_as_unread,),

            child: SvgPicture.asset(imagePath),

          ),

          Text(title,

            style: TextStyle(fontSize: 15),),

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