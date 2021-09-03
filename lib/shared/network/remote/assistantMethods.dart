// import 'package:geolocator/geolocator.dart';
// import 'package:sida_app/shared/components/constants.dart';
// import 'package:sida_app/shared/network/remote/requestAssistant.dart';
//
// class AssistantMethods{
//
//   static Future<String> getSearchCoordinateAddress(Position position)async{
//     String placeAddress = "";
//     String _url =
//         "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$MAP_API_KEY";
//
//     dynamic response = RequestAssistant.getRequest(_url);
//
//     if(response != "failed")
//       {
//
//         placeAddress = response["results"][0]["formatted_address"];
//
//       }
//     return placeAddress;
//
//
//   }
//
// }