import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sida_app/shared/components/components.dart';
import 'package:sida_app/helpers/helpermethods.dart';
import 'package:sida_app/shared/data_handler/data_provider.dart';
import 'package:sida_app/shared/data_handler/map_provider.dart';

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
                      title: "Cash",
                      image: "assets/images/dollar.svg",
                      onTap: (){},
                    ),
                    _divider(),
                    _buildBottomCard(
                      title: "Voucher",
                      image: "assets/images/gift_card.svg",
                      onTap: (){},
                    ),

                    _divider(),
                    _buildBottomCard(
                      title: "Features",
                      image: "assets/images/Group_124.svg",
                      onTap: (){},
                    ),
                    _divider(),
                    _buildBottomCard(
                      title: "Note to Driver",
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
        customHomeButton(context: context, title: "Book Now",
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
          left: 10,
          right: 10,

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

                  isSelected? Icon(Icons.remove_circle_outline): Icon(Icons.remove_circle_outline,
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
