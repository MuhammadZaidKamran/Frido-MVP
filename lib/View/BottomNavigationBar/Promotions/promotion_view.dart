import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/ad_view.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/promo_offer_details_view.dart';
import 'package:frido_app/Widgets/my_tab_bar.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

class PromotionView extends StatefulWidget {
  const PromotionView({super.key});

  @override
  State<PromotionView> createState() => _PromotionViewState();
}

class _PromotionViewState extends State<PromotionView> {
  final promoView = FirebaseDatabase.instance.ref('promoView');
  final adView = FirebaseDatabase.instance.ref('adView');
  List promoList = [];
  List adList = [];

  getPromoList() async {
    await promoView.get().then((value) {
      promoList = value.children.map((e) => e.value).toList();
    });
    print("promoList: $promoList");
    setState(() {});
  }

  getAdList() async {
    await adView.get().then((value) {
      adList = value.children.map((e) => e.value).toList();
    });
    print("adList: $adList");
    setState(() {});
  }

  initMethod() async {
    await getPromoList();
    await getAdList();
  }

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size(Get.width, Get.height * 0.2),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: Get.width,
            height: Get.height * 0.2,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myHeight(0.06),
                Text(
                  "Promotions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                myHeight(0.02),
                MyTabBar(tabOne: "Promo Viewer", tabTwo: "Ad Viewer"),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: TabBarView(
            children: [

              // Promo Viewer
              ListView.separated(
                shrinkWrap: true,
                itemCount: promoList.length,
                separatorBuilder: (context, index) => myHeight(0.02),
                itemBuilder: (context, index) {
                  final item = promoList[index];
                  return GestureDetector(
                    onTap:
                        () => Get.to(
                          () => PromoOfferDetailsView(
                            name: item['name'],
                            image: item['imageUrl'],
                            expireTime: item['expireAt'],
                            shortDescription: item['shortDescription'],
                            longDescription: item['longDescription'],
                            offerType: item['token']['view'],
                          ),
                        ),
                    child: Hero(
                      tag: Image.asset("assets/images/nike-air.jpg"),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        child: Container(
                          // height: Get.height * 0.2,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              (item['imageUrl'] == null ||
                                      item['imageUrl'] == "")
                                  ? Icon(
                                    Icons.image_not_supported_sharp,
                                    size: 40,
                                  )
                                  : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      "${item['imageUrl']}",
                                    ),
                                  ),
                              myWidth(0.025),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.4,
                                    child: Text(
                                      "${item['shortDescription']}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  myHeight(0.01),
                                  Text(
                                    "${item['expireAt']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  myHeight(0.01),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item['token']['view']}",
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
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: greenColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "New",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  myHeight(0.02),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: mainThemeColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "View Offer",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: whiteColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: whiteColor,
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
                  );
                },
              ),


              // Ad Viewer
              ListView.separated(
                shrinkWrap: true,
                itemCount: adList.length,
                separatorBuilder: (context, index) => myHeight(0.02),
                itemBuilder: (context, index) {
                  final item = adList[index];
                  return GestureDetector(
                    onTap:
                        () => Get.to(
                          () => AdOfferViewDetails(
                            name: item['name'],
                            shortDescription: item['shortDescription'],
                            offerType: item['token'],
                            expireAt: item['expireAt'],
                          ),
                        ),
                    child: Hero(
                      tag: Image.asset("assets/images/nike-air.jpg"),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              // (item['imageUrl'] == null ||
                              //         item['imageUrl'] == "")
                              //     ?
                              Icon(Icons.image_not_supported_sharp, size: 40),
                              // :
                              // CircleAvatar(
                              //   radius: 30,
                              //   backgroundImage: NetworkImage(
                              //     "${item['imageUrl']}",
                              //   ),
                              // ),
                              myWidth(0.025),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.4,
                                    child: Text(
                                      "${item['shortDescription']}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  myHeight(0.01),
                                  Text(
                                    "${item['expireAt']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  myHeight(0.01),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${item['token']}",
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
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: greenColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "New",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  myHeight(0.02),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: mainThemeColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "View Offer",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: whiteColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: whiteColor,
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
                  );
                },
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
