import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/data_handler/app_data.dart';
import 'package:sida_app/shared/styles/colors.dart';
import 'package:sida_app/screens/seach_screen.dart';
class WhereToScreen extends StatefulWidget {

  @override
  _WhereToScreenState createState() => _WhereToScreenState();
}

class _WhereToScreenState extends State<WhereToScreen> {
  // List<PlacePredictionsAutoComplete> autoCompletePredictionsList =[];

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    double barHeight = AppBar().preferredSize.height;
    Size mqSize = MediaQuery
        .of(context)
        .size;
    double leftRightPadding = 20;
    return Scaffold(


      body: SingleChildScrollView(

        child: Column(

            children: [


              Container(
                padding: EdgeInsets.only(left: leftRightPadding,
                  right: leftRightPadding,
                  bottom: 20,),
                height: mqSize.height * 0.25,
                decoration: BoxDecoration(
                  //   color: Colors.amber.shade400,
                  gradient: LinearGradient(
                    colors: [customAmberColor1, customAmberColor2],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 10,
                      //offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],

                ),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //TODO: GO BACK
                        Navigator.pop(context);
                      }
                      ,
                      child: Padding(
                        padding: EdgeInsets.only(top: statusbarHeight * 1.5),
                        child: Icon(Icons.arrow_back, color: Colors.black,),
                      ),
                    ),
                    Spacer(),
                    IntrinsicHeight(
                      child: Row(
                        //TODO: make it responsive
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          SvgPicture.asset("assets/images/Pickup_Flag.svg"),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 5),
                              //    width: mqSize.width * .7 - leftRightPadding * 2,

                              child: Text(
                                //  "El-Tahrir Square, ..."
                                Provider
                                    .of<AppData>(context)
                                    .userPickUpAddress
                                    .placeName,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black.withOpacity(0.3),
                                  fontWeight: FontWeight.bold,
                                ),
                                //   maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.black.withOpacity(0.3),
                            thickness: 1,
                          ),
                          Text("Building", style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/Target_Flag.svg"),
                          //  padding: EdgeInsets.only(left: 10, right: 5),

                          SizedBox(width: 10),
                          Container(
                            width: mqSize.width * .6 - leftRightPadding * 2,
                            child: TextFormField(

                              //enabled: false,
                              cursorHeight: 30,

                              cursorWidth: 3,
                              cursorColor: Colors.black,
                              onTap: () {
                                //TODO: GO TO search for destination


                                Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = [];
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));

                                // getAutoCompleteResult("mit");

                              },
                              // onChanged: (val) => getAutoCompleteResult(val),
                              autofocus: true,
                              showCursor: true,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                // contentPadding:
                                // EdgeInsets.only(top: 20),

                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0)
                                ,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: "Where to?",
                              ),

                            ),
                          ),

                        ],
                      ),
                    )


                  ],
                ),

              ),


              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  _buildTopItem(
                    imageName: "plus",
                    title: "Home",

                  ),
                  _buildTopItem(imageName: "plus", title: "Work",
                    onTap: () {},
                  ),
                  _buildTopItem(imageName: "star", title: "Favorites",
                    onTap: () {},
                  ),
                  _buildTopItem(imageName: "airport", title: "Airport",
                    onTap: () {},
                  ),

                ],
              ),
              Divider(
                thickness: 1,
                color: Color(0xffDBDBDB),
              ),
              _buildCustomRow(
                image: "clock",
                text: "Cairo - Al Wosta, Qasr Ad Dobarah, Qasr El Nil Cairo Governorate",
                onTap: () {},
              ),
              _buildCustomRow(
                image: "clock",
                text: "Airport, Terminal 1, Gate 2, Departure",
                onTap: () {},
              ),
              _buildCustomRow(
                image: "alarm",
                text: "I will show the driver",
                onTap: () {},
              ),
              _buildCustomRow(
                image: "pick_address",
                text: "Pick the address on the map",
                onTap: () {},
              ),


            ]
        ),
      ),

    );
  }


  Widget _buildTopItem({
    String imageName,
    String title,
    Function onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(

          padding: const EdgeInsets.all(10.0),
          //   margin: const EdgeInsets.only(top: 5),

          child: Column(children: [

            SvgPicture.asset("assets/images/$imageName.svg"),

            Padding(

              padding: EdgeInsets.only(top: 10),

              child: Text(title,

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 13,

                ),),

            )

          ],),

        ),
      );

  Widget _buildCustomRow({
    String image,
    String text,
    Function onTap,

  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 22,
        ),
        // width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(

                margin: const EdgeInsets.symmetric(vertical: 22),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/$image.svg"),
                    //  Icon(Icons.circle),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      child: Text(text,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Color(0xffDBDBDB),
              thickness: 1,
            ),
          ],
        ),
      );

  @override
  void initState() {
    //Show StatusBar
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    //To make it transparent StatusBar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    // TODO: implement initState
    //to hide app bar and status bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    //  SystemChrome.setSystemUIOverlayStyle(
    //      SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.0),
    //        statusBarIconBrightness: Brightness.dark,
    //      ));
    super.initState();
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIOverlays(
    //     [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

}

//   Future<void> getAutoCompleteResult(String destinationName)
//   async {
//
//     String ATUO_COMPLETE_URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$destinationName&key=$MAP_API_KEY&components=country:EG";
//
//     var response = await RequestAssistant.getRequest(ATUO_COMPLETE_URL);
//     if(response != "failed")
//     {
//       if(response["status"] == "OK")
//       {
//         print("Auto complete result " + response.toString());
//
//         var predictions = response["predictions"];
//         //  var placesList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
//         var placesAutoCompleteList = (predictions as List).map((e) => PlacePredictionsAutoComplete.fromJson(e)).toList();
//
//
//
//         Provider.of<AppData>(context, listen: false).autoCompletePredictionsList = placesAutoCompleteList;
//   //autoCompletePredictionsList  = placesAutoCompleteList;
//
//
//
//       }
//       else{
//         print("API ERROR");
//       }
//     }
//     else{
//       print("loading auto complete result failed");
//     }
//   }
//
// }





//
//
// class PredictionTile extends StatelessWidget
// {
//   final PlacePredictionsAutoComplete placePredictions;
//
//   PredictionTile({Key key, this.placePredictions}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return TextButton(
//
//  //    padding: EdgeInsets.all(0.0),
//       onPressed: ()
//       {
//       //  getPlaceAddressDetails(placePredictions.place_id, context);
//       },
//       child: Container(
//         child: Column(
//           children: [
//             SizedBox(width: 10.0,),
//             Row(
//               children: [
//                 Icon(Icons.add_location,),
//                 SizedBox(width: 14.0,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 8.0,),
//                       Text(placePredictions.main_text, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0),),
//                       SizedBox(height: 2.0,),
//                       Text(placePredictions.secondary_text, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0, color: Colors.white),),
//                       SizedBox(height: 8.0,),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(width: 10.0,),
//           ],
//         ),
//       ),
//     );
//   }  }