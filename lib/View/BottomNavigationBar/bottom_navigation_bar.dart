import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/promotion_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int myIndex = 0;
  List<Widget> pages = [HomeView(), PromotionView(), Scaffold(), Scaffold()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[myIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2)
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: mainThemeColor,
            unselectedItemColor: Colors.grey[600],
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            currentIndex: myIndex,
            onTap: (value) {
              setState(() {
                myIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: myIndex == 0 
                        ? mainThemeColor.withOpacity(0.2) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.home_rounded,
                    size: 26,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: myIndex == 1 
                        ? mainThemeColor.withOpacity(0.2) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    size: 26,
                  ),
                ),
                label: "Promotions",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: myIndex == 2 
                        ? mainThemeColor.withOpacity(0.2) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.wallet_rounded,
                    size: 26,
                  ),
                ),
                label: "Wallet",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: myIndex == 3 
                        ? mainThemeColor.withOpacity(0.2) 
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 26,
                  ),
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}