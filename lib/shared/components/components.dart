import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String title = "Update",
  Function onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Text(title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
    );

Widget customTextFormField({
  String label,
  Function validator,
  TextEditingController textController,
  TextInputType textInputType,
  String hint
}) =>
    TextFormField(
      controller: textController,
      keyboardType: textInputType,
//labelText:"label",

      decoration: InputDecoration(
        hintText: hint,
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

Widget customWhiteAppBar({String title, @required context})=>   AppBar(
  //  backgroundColor: Colors.red,
  centerTitle: true,
  title: Text(title,
    style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),),
  elevation: 0,
  backgroundColor: Colors.white,
  leading: InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Icon(Icons.arrow_back, color: Colors.black,
    ),
  ),
);

enum CarTypes {
  ANY_SIDA,
  SIDA_PLUS,
}


void defaultToast({
  @required message,
  @required ToastState state,
}) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0);
}

enum ToastState { ERROR, SUCCESSFUL, WARNING }

Color changeToastColor(ToastState state) {
  switch (state) {
    case ToastState.ERROR:
      return Colors.red[400];
      break;
    case ToastState.SUCCESSFUL:
      return Colors.green;
      break;
    case ToastState.WARNING:
      return Colors.orange;
      break;
    default:
      return null;
  }
}