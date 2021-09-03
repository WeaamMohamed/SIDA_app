import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sida_app/models/address_model.dart';
import 'package:sida_app/models/direction_details_model.dart';
import 'package:sida_app/models/place_predictions_auto_complete.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/network/remote/requestAssistant.dart';

enum HomeStatus {
  INITIAL,
  GET_DIRECTIONS,

}

class AppData extends ChangeNotifier
{


  List<PlacePredictionsAutoComplete> _autoCompletePredictionsList =[];
  AddressModel _userPickUpLocation;
  AddressModel _userDropOffLocation;
  HomeStatus _homeStatus = HomeStatus.INITIAL;
  DirectionDetails _directionDetails;

  void updatePickUpLocationAddress(AddressModel pickUpLocation){

    _userPickUpLocation = pickUpLocation;
    notifyListeners();

  }


  void updateDropOffLocationAddress(AddressModel dropOffLocation){

    _userDropOffLocation = dropOffLocation;
    notifyListeners();

  }



  Future<void> getAutoCompleteResult(String destinationName)
  async {

    String ATUO_COMPLETE_URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$destinationName&key=$MAP_API_KEY&components=country:EG";

    var response = await RequestAssistant.getRequest(ATUO_COMPLETE_URL);
    if(response != "failed")
    {
      if(response["status"] == "OK")
      {
        print("Auto complete result " + response.toString());

        var predictions = response["predictions"];
        //  var placesList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
        var placesAutoCompleteList = (predictions as List).map((e) => PlacePredictionsAutoComplete.fromJson(e)).toList();



        //Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = placesAutoCompleteList;
        autoCompletePredictionsList  = placesAutoCompleteList;



      }
      else{
        print("API ERROR");
      }
    }
    else{
      print("loading auto complete result failed");
    }
  }



  List<PlacePredictionsAutoComplete> get autoCompletePredictionsList =>
      _autoCompletePredictionsList;

  set autoCompletePredictionsList(List<PlacePredictionsAutoComplete> value) {
    _autoCompletePredictionsList = value;
    notifyListeners();
  }

  AddressModel get userDropOffLocation => _userDropOffLocation;
  AddressModel get userPickUpLocation => _userPickUpLocation;

  HomeStatus get homeStatus => _homeStatus;

  set homeStatus(HomeStatus value) {
    _homeStatus = value;
    notifyListeners();
  }


  void getDirectionDetails()async{
    // var initialPosition =  Provider.of<AppData>(context).userPickUpLocation;
    // var finalPosition = Provider.of<AppData>(context).userDropOffLocation;

    var pickUpLatLang = LatLng(userPickUpLocation.latitude, userPickUpLocation.longitude);
    var dropOffLatLang = LatLng(userDropOffLocation.latitude, userDropOffLocation.longitude);

    //TODO: progress bar
    _directionDetails = await RequestAssistant.getPlaceDirectionsDetails(pickUpLatLang, dropOffLatLang);
    print("this is your encoded points" + _directionDetails.encodedPoints);
    notifyListeners();


  }

  DirectionDetails get directionDetails => _directionDetails;

  set directionDetails(DirectionDetails value) {
    _directionDetails = value;
    notifyListeners();
  }

// set userDropOffLocation(AddressModel value) {
  //   _userDropOffLocation = value;
  // }
  //
  //
  // set userPickUpLocation(AddressModel value) {
  //   _userPickUpLocation = value;
  //
  // }
}

