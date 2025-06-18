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
  bool isExpanded = false;
  int totalUsage = 0;

  @override
  void initState() {
    super.initState();
    fetchAppStats();
  }

  // Helper function to format milliseconds to "Xh Ym"
  String formatHoursMinutes(int millis) {
    if (millis <= 0) return "0h 0m";

    int totalSeconds = millis ~/ 1000;
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;

    return "${hours}h ${minutes}m";
  }

  // Get the appropriate title based on selected filter
  String getScreenTimeTitle() {
    switch (selectedFilter) {
      case 'daily':
        return "Today, Screen Time";
      case 'weekly':
        return "This Week, Screen Time";
      case 'monthly':
        return "This Month, Screen Time";
      case 'yearly':
        return "This Year, Screen Time";
      default:
        return "Screen Time";
    }
  }

  Future<void> fetchAppStats([String interval = 'daily']) async {
    setState(() {
      isLoading = true;
      selectedFilter = interval;
      isExpanded = false;
    });

    appsStats = await homeController.getAppStats(interval);

    // Calculate total usage for the selected interval
    totalUsage = 0;
    for (var app in appsStats) {
      totalUsage += ((app['usageStats']?[interval] ?? 0) as int);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      getScreenTimeTitle(), // Dynamic title based on filter
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    myHeight(0.01),
                    Text(
                      formatHoursMinutes(totalUsage), // Dynamic total usage
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
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
              myHeight(0.03),
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
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      _buildAppListSection(),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppListSection() {
    // Filter out apps with zero usage
    final nonZeroApps =
        appsStats.where((app) {
          final usage = app['usageStats']?[selectedFilter] ?? 0;
          return usage > 0;
        }).toList();

    if (nonZeroApps.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text('No app usage data available'),
        ),
      );
    }

    // Determine which items to display
    final itemsToDisplay =
        isExpanded ? nonZeroApps : nonZeroApps.take(5).toList();

    return Column(
      children: [
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemsToDisplay.length,
          separatorBuilder: (context, index) => myHeight(0.03),
          itemBuilder: (context, index) {
            final app = itemsToDisplay[index];
            return ListTile(
              leading: homeController.imageFromBase64String(app['iconBase64']),
              title: Text(app['name'] ?? 'Unknown App'),
              trailing: Text(
                homeController.formatDurationFromMillis(
                  app['usageStats']?[selectedFilter] ?? 0,
                ),
              ),
            );
          },
        ),
        // Show toggle button only when there are more than 5 apps
        if (nonZeroApps.length > 5)
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'See less items' : 'See all items',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
      ],
    );
  }
}
