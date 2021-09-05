import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sida_app/models/direction_details_model.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/models/address_model.dart';
import 'package:sida_app/shared/data_handler/app_data.dart';

//For  reverse geocoding
class RequestAssistant
{



  static Future<dynamic> getRequest(String url) async
  {

    http.Response response = await http.get(Uri.parse(url));

    try
    {
      if(response.statusCode == 200)
      {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      }
      else
      {
        return "failed";
      }
    }
    catch(exp)
    {
      return "failed";
    }
  }


  static Future<String> getSearchCoordinateAddress({Position position, context}) async{
    String placeAddress = "";
    String _url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$MAP_API_KEY";



    http.Response response = await http.get( Uri.parse(_url));

    try
    {
      if(response.statusCode == 200)
      {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);


      //  dynamic response = RequestAssistant.getRequest(_url);

        AddressModel userPickUpAddress = new AddressModel();
        userPickUpAddress.longitude = position.longitude;
        userPickUpAddress.latitude = position.latitude;



      //  placeAddress += decodeData["results"][0]["formatted_address"];
        String str1, str2, str3, str4;
        placeAddress += decodeData["results"][0]["address_components"][0]["long_name"];
      //  placeAddress +=  ","  + decodeData["results"][0]["address_components"][1]["long_name"];
        placeAddress +=  ", "  + decodeData["results"][0]["address_components"][2]["long_name"];
        placeAddress +=  ", "  + decodeData["results"][0]["address_components"][3]["long_name"];
     //   placeAddress +=  ","  + decodeData["results"][0]["address_components"][4]["long_name"];
        // placeAddress += "," + decodeData["results"][0]["address_components"][5]["long_name"];
        // placeAddress += ","  + decodeData["results"][0]["address_components"][6]["long_name"];
        // placeAddress += ","  + decodeData["results"][0]["address_components"][7]["long_name"];
        userPickUpAddress.placeName = placeAddress;


        Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);

        print("Place Name : " +userPickUpAddress.placeName);
        print("Place address : " +placeAddress);

        // st1 = response["results"][0]["address_components"][4]["long_name"];
        // st2 = response["results"][0]["address_components"][7]["long_name"];
        // st3 = response["results"][0]["address_components"][6]["long_name"];
        // st4 = response["results"][0]["address_components"][9]["long_name"];
        // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;



        return placeAddress;


      }
      else
      {
        return "failed";

      }
    }
    catch(exp)
    {
      print("WEAAM"+ exp.toString());

      return "failed";
    }



  }


  //To get direction between pick up location and drop off location , get
  //som e information such as duration , distance ...
  static Future<DirectionDetails> getPlaceDirectionsDetails(LatLng initialPosition, LatLng finalPosition)async{

    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$MAP_API_KEY";


    var response = await getRequest(directionUrl);
    if(response != "failed")
      {
        if(response["status"] == "OK")
          {
            DirectionDetails _directionDetails =  DirectionDetails.fromMap(response);
            return _directionDetails;
          }


      }

    return null;

  }





}