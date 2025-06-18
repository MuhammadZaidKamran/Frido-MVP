import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/Widgets/my_button.dart';
import 'package:get/get.dart';

class AdOfferViewDetails extends StatefulWidget {
  const AdOfferViewDetails({super.key, required this.name, required this.shortDescription, required this.offerType, required this.expireAt});
  final String name;
  final String shortDescription;
  final String offerType;
  final String expireAt;

  @override
  State<AdOfferViewDetails> createState() => _AdOfferViewDetailsState();
}

class _AdOfferViewDetailsState extends State<AdOfferViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.23),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: Get.width,
          height: Get.height * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: [mainThemeColor, mainThemeColor.withOpacity(0.65)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // color: mainThemeColor,
          ),
          child: Hero(
            tag: AssetImage("assets/images/nike-air.jpg"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myHeight(0.03),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: whiteColor,
                      ),
                    ),
                    myWidth(0.04),
                    Text(
                      "Offer Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
                myHeight(0.04),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // (widget.image == null || widget.image == "")
                    //     ?
                         Icon(Icons.image_not_supported_sharp, size: 40),
                        // : CircleAvatar(
                        //   radius: 30,
                        //   backgroundImage: NetworkImage(widget.image),
                        // ),
                    myWidth(0.045),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.4,
                          child: Text(
                            widget.shortDescription,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.offerType,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          myWidth(0.01),
                          Image.asset(
                            "assets/images/token.png",
                            height: Get.height * 0.025,
                            width: Get.width * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: Get.width,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offer Duration:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: blackColor,
                    ),
                  ),
                  myHeight(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.expireAt,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "New",
                            style: TextStyle(fontSize: 14, color: blackColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            myHeight(0.02),
            Container(
              padding: EdgeInsets.all(8),
              width: Get.width,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.35),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offer Description:",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: blackColor,
                    ),
                  ),
                  // myHeight(0.01),
                  // Text(
                  //   widget.longDescription,
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w500,
                  //     color: blackColor,
                  //   ),
                  // ),
                ],
              ),
            ),
            myHeight(0.03),
            MyButton(onTap: () {}, label: "Claim Offer"),
          ],
        ),
      ),
    );
  }
}
