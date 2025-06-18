import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/promotion_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int myIndex = 0;
  List<Widget> pages = [HomeView(), PromotionView(), Scaffold(), Scaffold()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[myIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: mainThemeColor,
        unselectedItemColor: blackColor.withOpacity(0.7),
        type: BottomNavigationBarType.fixed,
        currentIndex: myIndex,
        onTap: (value) {
          myIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              // color: mainThemeColor,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_rounded),
            label: "Promotions",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.wallet_rounded),
            label: "Wallet",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
