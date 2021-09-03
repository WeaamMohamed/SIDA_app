import 'package:flutter/cupertino.dart';
import 'package:sida_app/models/address_model.dart';
import 'package:sida_app/models/place_predictions_auto_complete.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/network/remote/requestAssistant.dart';

class AppData extends ChangeNotifier
{

  List<PlacePredictionsAutoComplete> _autoCompletePredictionsList =[];
  AddressModel _userPickUpLocation;
  AddressModel _userDropOffLocation;

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


  AddressModel get userPickUpAddress => _userPickUpLocation;

  List<PlacePredictionsAutoComplete> get autoCompletePredictionsList =>
      _autoCompletePredictionsList;

  set autoCompletePredictionsList(List<PlacePredictionsAutoComplete> value) {
    _autoCompletePredictionsList = value;
    notifyListeners();
  }


}

