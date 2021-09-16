import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_app/models/address.dart';
import 'package:sida_app/models/direction_details.dart';
import 'package:sida_app/models/place_predictions_auto_complete.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/helpers/requesthelper.dart';

class MapProvider extends ChangeNotifier
{
  Polyline _polyline;

  Set<Marker> _markerSet ={};
  Set<Circle> _circleSet ={};
  List<LatLng> _pLineCoordinates = [];
  Set<Polyline> _polylineSet = {};

 // List<PlacePredictionsAutoComplete> _autoCompletePredictionsList =[];
  Address _userPickUpLocation;
  Address _userDropOffLocation;
  DirectionDetails _directionDetails;

  GoogleMapController _newGoogleMapController;
  int _autoCompletePredictionsLength = 0;

  void updatePickUpLocationAddress(Address pickUpLocation){
    _userPickUpLocation = pickUpLocation;
    notifyListeners();
  }


  void updateDropOffLocationAddress(Address dropOffLocation){
    _userDropOffLocation = dropOffLocation;
    notifyListeners();
  }

  Future<void> getAutoCompleteResult(String destinationName)
  async {

    String ATUO_COMPLETE_URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$destinationName&key=$MAP_API_KEY&components=country:EG";

    var response = await RequestHelper.getRequest(ATUO_COMPLETE_URL);
    if(response != "failed")
    {
      if(response["status"] == "OK")
      {
        print("Auto complete result " + response.toString());

        var predictions = response["predictions"];
        //  var placesList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
        var placesAutoCompleteList = (predictions as List).map((e) => PlacePredictionsAutoComplete.fromJson(e)).toList();



        //Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = placesAutoCompleteList;
        ///updateAutoCompletePredictionsList(placesAutoCompleteList) ;

        notifyListeners();


      }
      else{
        print("API ERROR");
      }
    }
    else{
      print("loading auto complete result failed");
    }
  }



  // List<PlacePredictionsAutoComplete> get autoCompletePredictionsList =>
  //     _autoCompletePredictionsList;
  //
  // void updateAutoCompletePredictionsList(List<PlacePredictionsAutoComplete> value) {
  //   _autoCompletePredictionsList = value;
  //   _autoCompletePredictionsLength = value.length;
  //
  //   notifyListeners();
 // }


  //int get autoCompletePredictionsLength => _autoCompletePredictionsLength;

  Address get userDropOffLocation => _userDropOffLocation;
  Address get userPickUpLocation => _userPickUpLocation;




  void getDirectionDetails()async{
    // var initialPosition =  Provider.of<AppData>(context).userPickUpLocation;
    // var finalPosition = Provider.of<AppData>(context).userDropOffLocation;

    var pickUpLatLang = LatLng(userPickUpLocation.latitude, userPickUpLocation.longitude);
    var dropOffLatLang = LatLng(userDropOffLocation.latitude, userDropOffLocation.longitude);

    //TODO: progress bar
    _directionDetails = await RequestHelper.getPlaceDirectionsDetails(pickUpLatLang, dropOffLatLang);
    print("this is your encoded points" + _directionDetails.encodedPoints);



    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(_directionDetails.encodedPoints);

    _pLineCoordinates.clear();

    if(decodedPolyLinePointsResult.isNotEmpty)
    {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        _pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    _polylineSet.clear();

    //  setState(() {
    _polyline = Polyline(
      color: Colors.red,
      polylineId: PolylineId("PolylineID"),
      jointType: JointType.round,
      points: _pLineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    _polylineSet.add(_polyline);
    //});

    LatLngBounds latLngBounds;
    if(pickUpLatLang.latitude > dropOffLatLang.latitude  &&  pickUpLatLang.longitude > dropOffLatLang.longitude)
    {
      latLngBounds = LatLngBounds(southwest: dropOffLatLang, northeast: pickUpLatLang);
    }
    else if(pickUpLatLang.longitude > dropOffLatLang.longitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLang.latitude, dropOffLatLang.longitude), northeast: LatLng(dropOffLatLang.latitude, pickUpLatLang.longitude));
    }
    else if(pickUpLatLang.latitude > dropOffLatLang.latitude)
    {
      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLang.latitude, pickUpLatLang.longitude), northeast: LatLng(pickUpLatLang.latitude, dropOffLatLang.longitude));
    }
    else
    {
      latLngBounds = LatLngBounds(southwest: pickUpLatLang, northeast: dropOffLatLang);
    }

    _newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    notifyListeners();


  }

  DirectionDetails get directionDetails => _directionDetails;

  set directionDetails(DirectionDetails value) {
    _directionDetails = value;
    notifyListeners();
  }

  Set<Polyline> get polylineSet => _polylineSet;

  GoogleMapController get newGoogleMapController => _newGoogleMapController;

  set newGoogleMapController(GoogleMapController value) {
    _newGoogleMapController = value;
    notifyListeners();
  }

}

