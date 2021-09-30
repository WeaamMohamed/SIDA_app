import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/localization/localization_method.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';
import 'package:rounded_modal/rounded_modal.dart';
class SelectAndConfirmRide extends StatefulWidget {
  final Function onTap;
  SelectAndConfirmRide({this.onTap});
  @override
  _SelectAndConfirmRideState createState() => _SelectAndConfirmRideState();
}

class _SelectAndConfirmRideState extends State<SelectAndConfirmRide> {
  CarTypes selectCarType = CarTypes.ANY_SIDA;
  final double mainHorizontalMargin = 15.0;


  @override
  Widget build(BuildContext context) {
    Size mqSize = MediaQuery.of(context).size;
    final double sizedBoxHeight =  mqSize.height * 0.016;
    final screenHeight= MediaQuery.of(context).size.height;
    final screenWidth= MediaQuery.of(context).size.width;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(

              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text(
                  "Trip",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      //"28",
                      Provider.of<MapProvider>(context).getCurrentDirectionDetails == null? ' duration':
                          Provider.of<MapProvider>(context).getCurrentDirectionDetails.durationText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   "min",
                    //   style: TextStyle(
                    //     fontSize: 11,
                    //   ),
                    // ),
                  ],
                ),
              ]),
              decoration: BoxDecoration(
                color: Colors.white,
                //shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(333),
              ),
            ),

            // Container(
            //   height: mqSize.height * 0.07,
            //   width: mqSize.width * 0.44,
            //   decoration: BoxDecoration(
            //     borderRadius: customBorderRadius,
            //     color: Colors.white,
            //   ),
            //   child: Row(
            //
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 5, right: 5,),
            //         child: Column(
            //
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //
            //             Text(
            //               "FOR OTHER",
            //               style: TextStyle(
            //                 fontSize: 13,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Text("(Book ride for a friend)", style: TextStyle(
            //               fontSize: 13,
            //             ),),
            //           ],
            //         ),
            //       ),
            //       Icon(Icons.arrow_forward_ios,
            //         color: Color(0xff5C6C7C),),
            //     ],
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),

        Container(
          padding: EdgeInsets.only(
            top: mqSize.height * 0.033,
            bottom: mqSize.height * 0.01,
            left: 15,
            right: 15,
            // horizontal: 15,
            // vertical: mqSize.height * 0.033,
          ),
          height: mqSize.height / 3.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: customBorderRadius,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 6,
                child: Row(

                  children: [
                    _buildCarTypesCard(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      mqSize: mqSize,
                      title: "Any SIDA",
                      imagePath: selectCarType ==CarTypes.ANY_SIDA?
                      "assets/images/ic_standard_active.png": "assets/images/ic_standard_passive.png" ,
                      //todo; change price
                      price: 22.4,
                      onTap: (){

                        setState(() {

                          selectCarType = CarTypes.ANY_SIDA;
                        });

                      },
                      isSelected: selectCarType == CarTypes.ANY_SIDA,

                    ),
                    _buildCarTypesCard(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      mqSize: mqSize,
                      title: "SIDA Plus",
                      imagePath: selectCarType ==CarTypes.SIDA_PLUS?
                      "assets/images/ic_comfort_active.png": "assets/images/ic_comfort_passive.png",
                      //todo; change price
                      price: 22.4,
                      onTap: (){
                        setState(() {
                          selectCarType = CarTypes.SIDA_PLUS;
                        });

                      },
                      isSelected: selectCarType == CarTypes.SIDA_PLUS,
                    ),
                    // _buildBuddyDriveCard(
                    //   mqSize: mqSize,
                    //   title: "Buddy \nDriver",
                    //
                    //   imagePath:  "assets/images/buddy_drive.svg" ,
                    //   onTap: (){},
                    // ),


                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                thickness: 1,

                color: Color(0xffE5E5E5),
              ),
              SizedBox(
                height: 4,
              ),
              Flexible(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBottomCard(
                      title: translate(context,'Cash'),
                      image: "assets/images/dollar.svg",
                      onTap: (){},
                    ),
                    _divider(),
                    _buildBottomCard(
                      title: translate(context,'Voucher'),
                      image: "assets/images/gift_card.svg",
                      onTap: (){},
                    ),

                    _divider(),
                    _buildBottomCard(
                      title: translate(context,'Features'),
                      image: "assets/images/Group_124.svg",
                      onTap: (){},
                    ),
                    _divider(),
                    _buildBottomCard(
                      title: translate(context,'Note to Driver'),
                      image: "assets/images/document.svg",
                      onTap: (){},
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: sizedBoxHeight,
        ),
        customHomeButton(context: context, title: translate(context,'Book Now'),
          onTap:  () {

         // widget.onTap();
         //  Provider.of<DataProvider>(context, listen: false).updateHomeStatus(HomeStatus.FINDING_RIDE) ;
         //  print(HomeStatus.FINDING_RIDE);
          String carType;
          selectCarType == CarTypes.SIDA_PLUS? carType = "SIDA Plus":  carType = "Any SIDA";
          Provider.of<DataProvider>(context, listen: false).updateCarType(carType);

          print("car type form select and confirm : "+ carType);
          // HelperMethods.createRideRequest(context: context, carType: carType);

            widget.onTap();
            print("weaam ontap called inside select and cofirm ride");
        },
        ),
      ],
    );
  }

  Widget _divider() => VerticalDivider(
    thickness: 1,
    color: Color(0xffE5E5E5),
  );

  Widget _buildCarTypesCard({
    final screenHeight,
    final screenWidth,
    Size mqSize,
    String imagePath,
    String title,
    double price,
    Function onTap,
    bool isSelected = false,
    bool comingSoon = false,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: customBorderRadius,
          color: isSelected ? Color(0xffFFF3D9): Colors.white,

        ),

        width: (mqSize.width - (mainHorizontalMargin * 2)) / 3.5,

        height: (mqSize.width - (mainHorizontalMargin * 2)) / 3.8,



        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
          bottom: 5,
        ),


        padding: EdgeInsets.only(
          left: 5,
          right: 5,

        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  comingSoon? Image.asset(
                    imagePath,
                    height: 30,
                    width: 50,
                  ): Image.asset(
                    imagePath,
                    height: 24,
                    width: 48,
                  ),

                  isSelected? IconButton(icon : Icon(Icons.info_outline), onPressed: ()
                  {
                    showModalBottomSheet<dynamic>(
                        isScrollControlled: true,

                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(
                              children: <Widget>[
                                Container(
                                  width: screenWidth,
                                  height: screenHeight*0.9,
                                  child: Container(
                              width: screenWidth,
                              height: screenHeight*0.9,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                            topLeft: const Radius.circular(200.0),
                                            topRight: const Radius.circular(200.0))
                                    ),
                                    child: selectCarType == CarTypes.ANY_SIDA? bottomsheetAnySIDA(context,screenHeight, screenWidth )
                                    : bottomsheetSIDAPlus(context,screenHeight, screenWidth ),
                                  ),
                                )
                              ]
                          );
                        }
                    );

                  },): Icon(Icons.info_outline,
                    color: Colors.transparent,),

                ],
              ),
              Text(title ,
                style: TextStyle(fontSize: 15),),
              if(!comingSoon) Row(
                //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "EGP",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    price.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      );



  Widget _buildBuddyDriveCard({
    Size mqSize,
    String imagePath,
    String title,
    Function onTap,
    bool isSelected = false,

  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: customBorderRadius,
          color: isSelected ? Color(0xffFFF3D9): Colors.white,

        ),

        width: (mqSize.width - (mainHorizontalMargin * 2)) / 3.8,
        //  width: mqSize.height * 0.11,
        height: (mqSize.width - (mainHorizontalMargin * 2)) / 3.8,
        //  height: 89,

        padding: EdgeInsets.only(
          left: 10,
          right: 5,
          top: 5,
          bottom: 5,
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(imagePath),
              ),

              SizedBox(height:10,),
              Text(title,
                style: TextStyle(fontSize: 15),),


            ],
          ),
        ),
      );
}

Widget _buildBottomCard({
  String image,
  String title,
  Function onTap
}) => Container(

// width: 55,

// height: 55,

  child: InkWell(
    onTap:onTap,
    child: Column(

// mainAxisAlignment: MainAxisAlignment.center,

// crossAxisAlignment: CrossAxisAlignment.stretch,

      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [
        SvgPicture.asset(image),
       // SizedBox(height: 5,),
        Center(
          child: Text(title,
            style: TextStyle(
              fontSize: 14,

            ),

          ),

        ),

      ],

    ),
  ),
);
Widget bottomsheetAnySIDA(context ,screenHeight,screenWidth)
{
  return Column(
              children: [
                SizedBox(height: 0.08* screenHeight),
                Image.asset('assets/images/anySIDA.jpg'),
                SizedBox(height: 0.01* screenHeight),
                Text('AnySIDA',
                    style: TextStyle(
                        color: Colors.black, fontSize: 35 ,fontWeight: FontWeight.bold)),
                SizedBox(height: 0.02* screenHeight),
                Flexible(
                  child: Text(translate(context,'For frequent comfortable city trips'),
                      style: TextStyle(
                          color: Colors.black, fontSize: 15)),
                ),
                SizedBox(height: 0.04* screenHeight),
                SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                SizedBox(height: 0.03* screenHeight),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 0.05* screenWidth),
                          SvgPicture.asset('assets/images/like.svg',width: 30,height: 30,),
                          SizedBox(width: 0.07 * screenWidth),
                          Flexible(
                            child: Text('Drivers are selected to be friendly,\nrespectful and polite.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          )
                        ],
                      ),
                      SizedBox(height: 0.04* screenHeight),
                      SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                      SizedBox(height: 0.03* screenHeight),
                      Row(
                        children: [
                          SizedBox(width: 0.05* screenWidth),
                          SvgPicture.asset('assets/images/steering-wheel.svg',width: 30,height: 30,),
                          SizedBox(width: 0.07 * screenWidth),
                          Flexible(
                            child: Text(translate(context,'Quality standards have been raised.'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          )
                        ],
                      ),
                      SizedBox(height: 0.04* screenHeight),
                      SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                      SizedBox(height: 0.02* screenHeight),
                      Row(
                        children: [
                          SizedBox(width: 0.05* screenWidth),
                          SvgPicture.asset('assets/images/comfortable.svg',width: 30,height: 30,),
                          SizedBox(width: 0.07 * screenWidth),
                          Flexible(
                            child: Text('Additional control over the cleanlin-\ness of the cabin, air conditioner and\nenvironment to provide comfortable\ntrip.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          )
                        ],
                      ),
                      SizedBox(height: 0.006* screenHeight),
                      Center(
                        child: Row(
                          children: [
                            SizedBox(width: 0.35* screenWidth),
                            IconButton(onPressed: ( ) {}, icon: Icon(Icons.circle, color: Colors.black,size: 15,)),
                            SizedBox(width: 0.02* screenWidth),
                            IconButton(onPressed: ( ) {

                            }, icon: Icon(Icons.circle, color: Colors.grey,size: 15,)),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.02* screenHeight),
                      SizedBox(
                        width: 0.88*screenWidth,
                        height: 0.07*screenHeight,
                        child: TextButton(
                            onPressed: ( ){
                              Navigator.pop(context);
                             },
                            style: ButtonStyle(
                                backgroundColor:   MaterialStateProperty.all<Color>(Colors.black),
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide()
                                    )
                                )
                            ),
                            child:   Align(
                              alignment: Alignment.center,
                              child: Text(translate(context,'Close'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                            )
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );

}
Widget bottomsheetSIDAPlus (context ,screenHeight,screenWidth)
{
  return Column(
              children: [
              SizedBox(height: 0.1* screenHeight),
                  Image.asset('assets/images/SIDAplus.jpg'),
                  SizedBox(height: 0.01* screenHeight),
                  Text('SIDA Plus',
            style: TextStyle(
                  color: Colors.black, fontSize: 35 ,fontWeight: FontWeight.bold)),
                  SizedBox(height: 0.02* screenHeight),
                  Flexible(
                  child: Text('Modern and comfortable cars for business\nor any celebration',
                  style: TextStyle(
            color: Colors.black, fontSize: 15)),
            ),
                SizedBox(height: 0.04* screenHeight),
                SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                SizedBox(height: 0.03* screenHeight),
                SingleChildScrollView(
            child: Column(
            children: [
            /// 1- like
            Row(
            children: [
                SizedBox(width: 0.05* screenWidth),
                SvgPicture.asset('assets/images/like.svg',width: 30,height: 30,),
                SizedBox(width: 0.07 * screenWidth),
                Flexible(
            child: Text('Only carefully selected drivers with\ngood ratings from passengers.',
            style: TextStyle(
            color: Colors.black, fontSize: 16.0)),
            )
            ],
            ),
                SizedBox(height: 0.04* screenHeight),
                SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                SizedBox(height: 0.03* screenHeight),
            /// 2- quality
            Row(
            children: [
                SizedBox(width: 0.05* screenWidth),
                SvgPicture.asset('assets/images/steering-wheel.svg',width: 30,height: 30,),
                SizedBox(width: 0.07 * screenWidth),
                Flexible(
                child: Text(translate(context,'Impeccable interior cleanliness.'),
                style: TextStyle(
                color: Colors.black, fontSize: 16.0)),
                )
                ],
                ),
                SizedBox(height: 0.04* screenHeight),
                SizedBox(height: 1.5,width:screenWidth*0.9-40, child: Container( color: HexColor('#E5E5E5'),),),
                SizedBox(height: 0.02* screenHeight),
                /// 3-
                Row(
                children: [
                SizedBox(width: 0.05* screenWidth),
                Image.asset('assets/images/shield.jpg',width: 30,height: 30,),
                SizedBox(width: 0.07 * screenWidth),
                Flexible(
                child: Text(translate(context,'High security vehicles.'),
                style: TextStyle(
                color: Colors.black, fontSize: 16.0)),
                )
                ],
                ),
                SizedBox(height: 0.01* screenHeight),
                Center(
                child: Row(
                children: [
                SizedBox(width: 0.35* screenWidth),
                IconButton(onPressed: ( ) {

                }, icon: Icon(Icons.circle, color: Colors.grey,size: 15,)),
                SizedBox(width: 0.02* screenWidth),
                IconButton(onPressed: ( ) {
                /// plus SIDA
                }, icon: Icon(Icons.circle, color: Colors.black,size: 15,)),
                ],
                ),
                ),
                SizedBox(height: 0.03* screenHeight),
                SizedBox(
                width: 0.88*screenWidth,
                height: 0.07*screenHeight,
                child: TextButton(
                onPressed: ( ){
                  Navigator.pop(context);
                    },
                    style: ButtonStyle(
                backgroundColor:   MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.amber),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide()
                )
                )
                ),
                child:   Align(
                alignment: Alignment.center,
                child: Text(translate(context,'Close'),
                style: TextStyle(
                color: Colors.white, fontSize: 18 ,fontWeight: FontWeight.bold)),
                )
                ),
                ),

            ],
            ),
            )
            ],

            );
}


