import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class button extends StatelessWidget {
  button({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 87.0, middle: 0.5),
            Pin(size: 28.0, middle: 0.5),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      color: const Color(0xff000000),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 1.0, middle: 0.5058),
                  Pin(start: 0.5, end: 0.5),
                  child: SvgPicture.string(
                    _svg_un7d2j,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 15.0, middle: 0.8082),
                  Pin(size: 14.0, middle: 0.5),
                  child: Text(
                    'EN',
                    style: TextStyle(
                      fontFamily: 'Spoqa Han Sans Neo',
                      fontSize: 11,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 14.0, middle: 0.1918),
                  Pin(size: 14.0, middle: 0.5),
                  child: Text(
                    'AR',
                    style: TextStyle(
                      fontFamily: 'Spoqa Han Sans Neo',
                      fontSize: 11,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 44.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14.0),
                        bottomRight: Radius.circular(14.0),
                      ),
                      color: const Color(0x80f4b204),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_un7d2j =
    '<svg viewBox="314.5 423.5 1.0 27.0" ><path transform="translate(314.5, 423.5)" d="M 0 0 L 0 27" fill="none" stroke="#f4b204" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
