import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/models/address.dart';
import 'package:sida_app/models/place_predictions_auto_complete.dart';
import 'package:sida_app/shared/components/constants.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:sida_app/helpers/requesthelper.dart';
import 'home_screen.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';

// class SearchScreen extends StatefulWidget {
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController dropOffTextEditingController = TextEditingController();
//   @override
//
//
//   @override
//   void deactivate() {
//     Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = [];
//
//   }
//
//
//
//
//   // @override
//   // void dispose() {
//   //
//   //   Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = [];
//   //   super.dispose();
//   // }
// }

class NewSearchScreen extends StatefulWidget {

  @override
  _NewSearchScreenState createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {

  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictionsAutoComplete> placePredictionList = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: TextField(
                  onChanged: (val)
                  {
                    findPlace(val);
                 //   Provider.of<MapProvider>(context, listen: false).getAutoCompleteResult(val);
                    //  Provider.of(val);
                  },
                  controller: dropOffTextEditingController,
                  decoration: InputDecoration(
                    hintText: translate(context,'Where to?'),
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                  ),
                ),
              ),),
         ///   Provider.of<MapProvider>(context).autoCompletePredictionsLength > 0?
            (placePredictionList.length > 0)?
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, ),
                child: ListView.separated(
                  padding: EdgeInsets.all(0.0),
                  itemBuilder: (context, index)
                  {
                    return PredictionTile(placePredictions: placePredictionList[index],);
                  },
                  separatorBuilder: (BuildContext context, int index) => Container(),
                  /// itemCount: Provider.of<MapProvider>(context).autoCompletePredictionsList.length,
                  itemCount:placePredictionList.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                ),
              ),
            )
                : Container(),


          ],
        ),
      ),

    );




  }

  void findPlace(String destinationName) async
  {
    if(destinationName.length > 1)
    {
      String ATUO_COMPLETE_URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$destinationName&key=$MAP_API_KEY&components=country:EG";

      var res = await RequestHelper.getRequest(ATUO_COMPLETE_URL);

      if(res == "failed")
      {
        return;
      }

      if(res["status"] == "OK")
      {
        var predictions = res["predictions"];

        var placesList = (predictions as List).map((e) => PlacePredictionsAutoComplete.fromJson(e)).toList();

        setState(() {
          placePredictionList = placesList;
        });

        print(placePredictionList);
      }
    }
  }
}



class PredictionTile extends StatelessWidget
{
  final PlacePredictionsAutoComplete placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return TextButton(

      //    padding: EdgeInsets.all(0.0),
      onPressed: ()
      {

        //TODO: progress bar
        getPlaceAddressDetails(placeId: placePredictions.placeId, context: context);
        //  getPlaceAddressDetails(placePredictions.placeId, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location, color: Colors.grey,),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(placePredictions.mainText, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0, color: Colors.black),),
                      SizedBox(height: 2.0,),
                      Text(placePredictions.secondaryText, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0, color: Colors.grey),),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0,),
          ],
        ),
      ),
    );


  }

  void getPlaceAddressDetails({String placeId, context}) async{


    //TODO: show progress bar.
    // &fields=name,rating,formatted_phone_number
    String detailUrl = "https://maps.googleapis.com/maps/api/place/details/json?placeId=$placeId&key=$MAP_API_KEY";

    var response = await RequestHelper.getRequest(detailUrl);
    if(response != "failed")
    {
      if(response["status"] == "OK")
      {
        Address dropOffAddress = Address(
          placeName: response["result"]["name"],
          latitude: response["result"]["geometry"]["location"]["lat"],
          longitude: response["result"]["geometry"]["location"]["lng"],
          placeId: placeId,
        );

        Provider.of<MapProvider>(context, listen: false).updateDropOffLocationAddress(dropOffAddress);


        print("your drop off location: " + dropOffAddress.placeName);
      //  Provider.of<MapProvider>(context, listen: false).updateAutoCompletePredictionsList([]);
        Provider.of<MapProvider>(context, listen: false).getDirectionDetails();

        //Navigator.pop(context, "getDirections");

        Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.SELECT_AND_CONFIRM_RIDE);
        ///TODO:change to user id in homescreen()
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context,) => HomeScreen(),), (route) => false);


      }
      else
      {
        print("API ERROR");
      }


    }
    else
    {
      print("Failed to load place address details ");
    }

  }



}

