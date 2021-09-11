import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final List<BoxShadow> shadows;

  AnimatedToggle({
    @required this.values,
    @required this.onToggleCallback,
    this.backgroundColor = const Color(0xff000000),
    this.buttonColor = const Color(0xfff4b204),
    this.textColor = const Color(0xff000000),
    this.shadows = const [
      BoxShadow(
        color: const Color(0x29000000),
        spreadRadius: 5,
        blurRadius: 6,
        offset: Offset(0, 3),
      ),
    ],
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

//bool initialPosition = true;

class _AnimatedToggleState extends State<AnimatedToggle> {

  @override
  Widget build(BuildContext context) {
    var mProvider = Provider.of<DataProvider>(context);
    return Container(
      width: 87,
      height: 28,
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {

             /// initialPosition = !initialPosition;
              Provider.of<DataProvider>(context, listen: false).toggleLanguage();


             /// var index = 0;
              ///
              ///int index;
             /// mProvider.isEnglish? index = 0: index = 1;
              //if initial position is false
              // if (!mProvider.isEnglish) {
              //   index = 1;
              // }
              //TODO: here is error
              widget.onToggleCallback(mProvider.isEnglish);
              setState(() {});
            },
            child: Container(
              width: 87,
              height: 28,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
            mProvider.isEnglish ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 44,
              height: 28,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shadows: widget.shadows,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                mProvider.isEnglish ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: widget.textColor,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}