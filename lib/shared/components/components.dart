import 'package:flutter/material.dart';
import 'package:sida_app/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customHomeButton({
  @required context,
  String title,
  bool withIcon =false,
  Function onTap,

}) =>
    Container(
      width: MediaQuery.of(context).size.width, height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
    gradient: LinearGradient(colors: <Color>[customAmberColor1, customAmberColor2],),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 2),
            blurRadius: 7,
            spreadRadius: 1.2,
          ),
        ],
      ),
      child:
      Material(
     color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Row(
               mainAxisAlignment: !withIcon? MainAxisAlignment.center: MainAxisAlignment.start,
              children: [
              if(withIcon) Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SvgPicture.asset("assets/images/Pickup_Flag.svg"),
                ),
                Container(
                 width: MediaQuery.of(context).size.width * 0.8 - 15 ,
                  child: Center(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: withIcon?TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ): TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
