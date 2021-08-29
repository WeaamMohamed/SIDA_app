import 'package:flutter/material.dart';

Widget defaultTextForm({
  @required IconData icon,
  @required String labelText,
  IconData suffixIcon,
  @required TextEditingController controller,
  @required TextInputType keyboardType,
  Function onSubmitted,
  Function validator,
  bool isObscure = false,
  Function onSuffixPressed,
  Function onTap,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      obscureText: isObscure,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 13,
          color: Colors.red[700], // or any other color
        ),
        labelText: labelText,
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  Color color = const Color(0xFF397ba3),
//  Color color = HexColor('#397ba3'),
  @required String text,
  @required Function onPressed,
  double width = double.infinity,
}) =>
    Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );


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

Widget defaultFavoriteIconButton({
  @required Function onPressed,
  @required Color backgroundColor,
}) =>
    CircleAvatar(
//  radius: 20,
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: Icon(
          Icons.favorite_outline,
          color: Colors.white,
//  color: Colors.,
        ),
        onPressed: onPressed,
      ),
    );
