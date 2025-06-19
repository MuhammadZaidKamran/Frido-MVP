import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/ad_view.dart';
import 'package:frido_app/View/BottomNavigationBar/Promotions/promo_offer_details_view.dart';
import 'package:get/get.dart';

class PromotionView extends StatefulWidget {
  const PromotionView({super.key});

  @override
  State<PromotionView> createState() => _PromotionViewState();
}

class _PromotionViewState extends State<PromotionView> with SingleTickerProviderStateMixin {
  final promoView = FirebaseDatabase.instance.ref('promoView');
  final adView = FirebaseDatabase.instance.ref('adView');
  List promoList = [];
  List adList = [];
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.wait([_getPromoList(), _getAdList()]);
    setState(() => _isLoading = false);
  }

  Future<void> _getPromoList() async {
    final snapshot = await promoView.get();
    if (snapshot.exists) {
      promoList = snapshot.children.map((e) => e.value).toList();
    }
  }

  Future<void> _getAdList() async {
    final snapshot = await adView.get();
    if (snapshot.exists) {
      adList = snapshot.children.map((e) => e.value).toList();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildAppBar(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _isLoading ? _buildLoadingList() : _buildPromoList(),
                _isLoading ? _buildLoadingList() : _buildAdList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mainThemeColor, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(top: 60, bottom: 20, left: 24, right: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Exclusive Offers',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 6),
          Text(
            'Earn tokens by viewing promotions & ads',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(50),
    ),
    child: TabBar(
      controller: _tabController,
      indicator: BoxDecoration(
        color: mainThemeColor,
        borderRadius: BorderRadius.circular(50),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black87,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      indicatorPadding: const EdgeInsets.all(2),
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(text: 'Promotions'),
        Tab(text: 'Advertisements'),
      ],
    ),
  );
}


  Widget _buildLoadingList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (_, index) => Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildPromoList() {
    if (promoList.isEmpty) {
      return _buildEmptyState("No promotions available", Icons.local_offer);
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: promoList.length,
        itemBuilder: (context, index) {
          final item = promoList[index];
          return _buildOfferCard(
            title: item['name'],
            description: item['shortDescription'],
            imageUrl: item['imageUrl'],
            expiry: item['expireAt'],
            tokens: item['token']['view'],
            onTap: () => Get.to(() => PromoOfferDetailsView(
                  name: item['name'],
                  image: item['imageUrl'],
                  expireTime: item['expireAt'],
                  shortDescription: item['shortDescription'],
                  longDescription: item['longDescription'],
                  offerType: item['token']['view'],
                )),
          );
        },
      ),
    );
  }

  Widget _buildAdList() {
    if (adList.isEmpty) {
      return _buildEmptyState("No ads available", Icons.ad_units);
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: adList.length,
        itemBuilder: (context, index) {
          final item = adList[index];
          return _buildOfferCard(
            title: item['name'],
            description: item['shortDescription'],
            expiry: item['expireAt'],
            tokens: item['token'],
            onTap: () => Get.to(() => AdOfferViewDetails(
                  name: item['name'],
                  shortDescription: item['shortDescription'],
                  offerType: item['token'],
                  expireAt: item['expireAt'],
                )),
          );
        },
      ),
    );
  }

  Widget _buildOfferCard({
    String? imageUrl,
    required String title,
    required String description,
    required String expiry,
    required dynamic tokens,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 40),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(
                        backgroundColor: Colors.orange[50],
                        avatar: const Icon(Icons.access_time, size: 16, color: Colors.orange),
                        label: Text(
                          expiry,
                          style: const TextStyle(color: Colors.orange, fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber[600],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "+$tokens",
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.monetization_on_outlined,
                                size: 18, color: Colors.white),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _loadData,
              style: TextButton.styleFrom(foregroundColor: mainThemeColor),
              child: const Text("Refresh"),
            )
          ],
        ),
      ),
    );
  }
}
