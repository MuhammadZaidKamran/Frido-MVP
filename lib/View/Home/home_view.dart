import 'package:flutter/material.dart';
import 'package:frido_app/Controller/home_controller.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/Widgets/category_row_widget.dart';
import 'package:frido_app/Widgets/task_options_container.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeControllers homeController = HomeControllers();

  List<Map> appsStats = [];
  bool isLoading = true;
  String selectedFilter = 'daily';
  int tabIndex = 0;
  int displayItemCount = 5;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    fetchAppStats();
  }

  Future<void> fetchAppStats([String interval = 'daily']) async {
    setState(() {
      isLoading = true;
      selectedFilter = interval;
    });

    appsStats = await homeController.getAppStats(interval);
    setState(() {
      isLoading = false;
    });
  }

  Widget filterButton(String label) {
    final isSelected = selectedFilter == label.toLowerCase();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () => fetchAppStats(label.toLowerCase()),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    List itemsToDisplay = appsStats.take(displayItemCount).toList();
    return Scaffold(
      appBar: AppBar(backgroundColor: whiteColor, toolbarHeight: 10),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,Weekend",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: mainThemeColor,
                ),
              ),
              myHeight(0.02),
              Container(
                padding: EdgeInsets.all(8),
                width: Get.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.2),
                      // color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today, Screen Time",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    myHeight(0.01),
                    Text(
                      "5h 24m",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // myHeight(0.03),
              // Filter buttons row
              myHeight(0.03),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TaskOptionsContainer(
                      title: "Daily",
                      textColor: tabIndex == 0 ? whiteColor : mainThemeColor,
                      backgroundColor:
                          tabIndex == 0 ? mainThemeColor : whiteColor,
                      borderColor:
                          tabIndex == 0
                              ? Colors.transparent
                              : Colors.transparent,
                      onTap: () {
                        tabIndex = 0;
                        fetchAppStats('daily');
                      },
                    ),
                    Expanded(
                      child: TaskOptionsContainer(
                        title: "Weekly",
                        textColor: tabIndex == 1 ? whiteColor : mainThemeColor,
                        backgroundColor:
                            tabIndex == 1 ? mainThemeColor : whiteColor,
                        borderColor:
                            tabIndex == 1
                                ? Colors.transparent
                                : Colors.transparent,
                        onTap: () {
                          tabIndex = 1;
                          fetchAppStats('weekly');
                        },
                      ),
                    ),
                    Expanded(
                      child: TaskOptionsContainer(
                        title: "Monthly",
                        textColor: tabIndex == 2 ? whiteColor : mainThemeColor,
                        backgroundColor:
                            tabIndex == 2 ? mainThemeColor : whiteColor,
                        borderColor:
                            tabIndex == 2
                                ? Colors.transparent
                                : Colors.transparent,
                        onTap: () {
                          tabIndex = 2;
                          fetchAppStats('monthly');
                        },
                      ),
                    ),
                    Expanded(
                      child: TaskOptionsContainer(
                        title: "Yearly",
                        textColor: tabIndex == 3 ? whiteColor : mainThemeColor,
                        backgroundColor:
                            tabIndex == 3 ? mainThemeColor : whiteColor,
                        borderColor:
                            tabIndex == 3
                                ? Colors.transparent
                                : Colors.transparent,
                        onTap: () {
                          tabIndex = 3;
                          fetchAppStats('yearly');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     filterButton('Daily'),
              //     filterButton('Weekly'),
              //     filterButton('Monthly'),
              //     // filterButton('Yearly'),
              //   ],
              // ),
              // const SizedBox(height: 20),
              myHeight(0.03),
              // Content area
              Container(
                padding: EdgeInsets.all(12),
                width: Get.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top 5 Apps",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    myHeight(0.01),
                    SizedBox(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemsToDisplay.length,
                        separatorBuilder: (context, index) => myHeight(0.03),
                        itemBuilder: (context, index) {
                          final app = itemsToDisplay[index];
                          return ListTile(
                            leading: homeController.imageFromBase64String(
                              app['iconBase64'],
                            ),
                            title: Text(app['name'] ?? 'Unknown App'),
                            trailing: Text(
                              homeController.formatDurationFromMillis(
                                app['usageStats']?[selectedFilter] ?? 0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (!isExpanded)
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              displayItemCount = appsStats.length;
                              isExpanded = true;
                            });
                          },
                          child: Text(
                            'See all items',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              myHeight(0.02),
              Container(
                padding: EdgeInsets.all(12),
                width: Get.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "App Categories",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    myHeight(0.01),
                    CategoryRowWidget(title: "Social", duration: "2h 30m"),
                    myHeight(0.01),
                    CategoryRowWidget(
                      title: "Entertainment",
                      duration: "2h 30m",
                    ),
                    myHeight(0.01),
                    CategoryRowWidget(title: "Production", duration: "2h 30m"),
                  ],
                ),
              ),
              // Expanded(
              //   child:
              //       isLoading
              //           ? const Center(child: CircularProgressIndicator())
              //           : appsStats.isEmpty
              //           ? const Center(child: Text('No data available'))
              //           : ListView.separated(
              //             itemCount: appsStats.length,
              //             separatorBuilder: (_, __) => const Divider(),
              //             itemBuilder: (context, index) {
              //               final app = appsStats[index];
              //               return ListTile(
              //                 leading: homeController.imageFromBase64String(
              //                   app['iconBase64'],
              //                 ),
              //                 title: Text(app['name'] ?? 'Unknown App'),
              //                 trailing: Text(
              //                   homeController.formatDurationFromMillis(
              //                     app['usageStats']?[selectedFilter] ?? 0,
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
