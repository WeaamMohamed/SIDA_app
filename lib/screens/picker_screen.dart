import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sida_app/google_maps_picker/src/components/animated_pin.dart';
import 'package:sida_app/google_maps_picker/src/models/pick_result.dart';
import 'package:sida_app/google_maps_picker/src/place_picker.dart';



class PickerScreen extends StatefulWidget {

  @override
  _PickerScreenState createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(

      hintText: "Drop off location",

      automaticallyImplyAppBarLeading: true,
      hidePlaceDetailsWhenDraggingPin: true,
      pinBuilder: (context, state) {
        if (state == PinState.Idle) {
          return Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('assets/images/pickup_pin.svg'),
                    SizedBox(height: 42),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedPin(child: SvgPicture.asset('assets/images/pickup_pin.svg')),
                    SizedBox(height: 42),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        }
      },
      // onPlacePicked: (result) {
      //   selectedPlace = result;
      //   Navigator.of(context).pop();
      //   setState(() {});
      // },

      // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
      //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
      //   return isSearchBarFocused
      //       ? Container()
      //       : FloatingCard(
      //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
      //           leftPosition: 0.0,
      //           rightPosition: 0.0,
      //           width: 500,
      //           borderRadius: BorderRadius.circular(12.0),
      //           child: state == SearchingState.Searching
      //               ? Center(child: CircularProgressIndicator())
      //               : RaisedButton(
      //                   child: Text("Pick Here"),
      //                   onPressed: () {
      //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
      //                     //            this will override default 'Select here' Button.
      //                     print("do something with [selectedPlace] data");
      //                     Navigator.of(context).pop();
      //                   },
      //                 ),
      //         );
      // },
    );
  }
}
