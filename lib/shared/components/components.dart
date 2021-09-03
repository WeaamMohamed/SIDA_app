import 'package:flutter/material.dart';
import 'package:sida_app/shared/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customHomeButton({
  @required context,
  String title,
  bool withIcon = false,
  Function onTap,
}) =>
    Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: customBorderRadius,
        gradient: LinearGradient(
          colors: <Color>[customAmberColor1, customAmberColor2],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            offset: Offset(0.0, 2),
            blurRadius: 7,
            spreadRadius: 1.2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: !withIcon
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (withIcon)
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: SvgPicture.asset("assets/images/Pickup_Flag.svg"),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8 - 15,
                  child: Center(
                    child: Text(
                      title ?? "location",
                      overflow: TextOverflow.ellipsis,
                      style: withIcon
                          ? TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
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

Widget customBlackButton({
  String title,
  Function onTap,
}) =>
    Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.black,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Center(
              child: Text("Update",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )),
      ),
    );

Widget customTextFormField({
  String label,
  Function validator,
  TextEditingController textController,
  TextInputType textInputType,
}) =>
    TextFormField(
      controller: textController,
      keyboardType: textInputType,
//labelText:"label",

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.0,),

        errorStyle: TextStyle(
          fontSize: 13,
          color: Colors.red[700],
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Color(0xffA9ACB6),
          fontWeight: FontWeight.bold,
        ),
      ),
      cursorColor: Colors.black,
      style: TextStyle(
        fontSize: 15,
      ),
      validator: validator,
    );
BorderRadius customBorderRadius = BorderRadius.circular(8);

enum CarTypes {
  ANY_SIDA,
  SIDA_PLUS,
}
