import 'package:flutter/material.dart';
import 'package:sida_app/google_maps_picker/src/components/rounded_frame.dart';

class FloatingCard extends StatelessWidget {
  const FloatingCard({
    Key key,
    this.topPosition,
    this.leftPosition,
    this.rightPosition,
    this.bottomPosition,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.elevation = 0.0,
    this.color,
    this.child,
  }) : super(key: key);

  final double topPosition;
  final double leftPosition;
  final double bottomPosition;
  final double rightPosition;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final double elevation;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: leftPosition,
      right: rightPosition,
      bottom: bottomPosition,
      child: Container(
        height: 93,
        decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15),),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const <Color> [Color(0xffFED444), Color(0xffFEBA3F)],
        )
      ),
        child: RoundedFrame(
          width: width,
          height: height,
          borderRadius: borderRadius,
          elevation: elevation,
          color: color,
          child: child,
        ),
      ),
    );
  }
}
