import 'package:flutter/material.dart';
import 'package:frido_app/Controller/home_controller.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/Global/global.dart';
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
  String currentPersona = "Focused Fox";

  // Predefined app categories with common apps
  static const Map<String, List<String>> appCategories = {
    'Social': [
      'Instagram', 'Facebook', 'WhatsApp', 'Messenger',
      'Twitter', 'Snapchat', 'LinkedIn', 'Telegram',
      'Discord', 'Reddit', 'Pinterest', 'TikTok',
      'ShareChat', 'Helo', 'Likee', 'MX TakaTak'
    ],
    'Entertainment': [
      'YouTube', 'Netflix', 'Spotify', 'Disney+',
      'Prime Video', 'Hotstar', 'JioCinema', 'ZEE5',
      'SonyLIV', 'Voot', 'MX Player', 'Gaana',
      'Wynk Music', 'Amazon Music', 'Apple Music', 'Spotify'
    ],
    'Productivity': [
      'Gmail', 'Outlook', 'Google Drive', 'OneDrive',
      'Microsoft Office', 'Slack', 'Zoom', 'Teams',
      'Notion', 'Evernote', 'Todoist', 'Trello',
      'Google Keep', 'Google Docs', 'Google Sheets'
    ],
    'Games': [
      'PUBG', 'Free Fire', 'Candy Crush', 'Among Us',
      'Clash of Clans', 'Clash Royale', 'Ludo King',
      'Subway Surfers', 'Temple Run', '8 Ball Pool',
      'Call of Duty', 'Asphalt', 'Genshin Impact'
    ],
    'Other': []
  };

  @override
  void initState() {
    super.initState();
    fetchAppStats();
  }

  String formatHoursMinutes(int millis) {
    if (millis <= 0) return "0h 0m";
    int totalSeconds = millis ~/ 1000;
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    return "${hours}h ${minutes}m";
  }

  String getScreenTimeTitle() {
    switch (selectedFilter) {
      case 'daily': return "Today's Screen Time";
      case 'weekly': return "This Week's Screen Time";
      case 'monthly': return "This Month's Screen Time";
      case 'yearly': return "This Year's Screen Time";
      default: return "Screen Time";
    }
  }

  Future<void> fetchAppStats([String interval = 'daily']) async {
    setState(() {
      isLoading = true;
      selectedFilter = interval;
      isExpanded = false;
    });

    appsStats = await homeController.getAppStats(interval);
    totalUsage = appsStats.fold(0, (sum, app) => sum + ((app['usageStats']?[interval] ?? 0) as int));

    setState(() => isLoading = false);
  }

  Map<String, int> getCategoryStats() {
    final Map<String, int> categories = {};
    for (final category in appCategories.keys) {
      categories[category] = 0;
    }

    for (final app in appsStats) {
      final appName = app['name']?.toString() ?? 'Unknown';
      final usage = (app['usageStats']?[selectedFilter] ?? 0) as int;
      bool categorized = false;

      for (final category in appCategories.keys) {
        if (appCategories[category]!.any((pattern) => 
            appName.toLowerCase().contains(pattern.toLowerCase()))) {
          categories[category] = categories[category]! + usage;
          categorized = true;
          break;
        }
      }

      if (!categorized) {
        categories['Other'] = categories['Other']! + usage;
      }
    }

    return categories;
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Social': return Icons.people_alt;
      case 'Entertainment': return Icons.movie;
      case 'Productivity': return Icons.work;
      case 'Games': return Icons.sports_esports;
      default: return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryStats = getCategoryStats();
    final sortedCategories = categoryStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildScreenTimeCard(),
              const SizedBox(height: 24),
              _buildTimePeriodSelector(),
              const SizedBox(height: 24),
              _buildTopAppsSection(),
              const SizedBox(height: 24),
              _buildCategoriesSection(sortedCategories),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello, User!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: mainThemeColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Your current persona: $currentPersona",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildScreenTimeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [mainThemeColor, Colors.purple[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: mainThemeColor.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.phone_android, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                getScreenTimeTitle(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            formatHoursMinutes(totalUsage),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.6,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            "You're ${_getComparisonText()} your ${selectedFilter} average",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _getComparisonText() => "20% below";

  Widget _buildTimePeriodSelector() {
    const List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
    
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                tabIndex = index;
                fetchAppStats(periods[index].toLowerCase());
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: tabIndex == index ? mainThemeColor : whiteColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: tabIndex == index ? Colors.transparent : Colors.grey[300]!,
                ),
                boxShadow: tabIndex == index
                  ? [BoxShadow(
                      color: mainThemeColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )]
                  : null,
              ),
              child: Center(
                child: Text(
                  periods[index],
                  style: TextStyle(
                    color: tabIndex == index ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopAppsSection() {
    if (isLoading) return Center(child: CircularProgressIndicator());

    final nonZeroApps = appsStats.where((app) {
      return ((app['usageStats']?[selectedFilter] ?? 0) as int) > 0;
    }).toList();

    if (nonZeroApps.isEmpty) {
      return Center(child: Text('No app usage data available'));
    }

    nonZeroApps.sort((a, b) => 
      ((b['usageStats']?[selectedFilter] ?? 0) as int)
      .compareTo((a['usageStats']?[selectedFilter] ?? 0) as int));

    final displayedApps = isExpanded ? nonZeroApps : nonZeroApps.take(5).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Apps",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...displayedApps.map((app) => _buildAppListItem(app)),
          if (nonZeroApps.length > 5)
            Center(
              child: TextButton(
                onPressed: () => setState(() => isExpanded = !isExpanded),
                child: Text(
                  isExpanded ? 'Show Less' : 'Show All',
                  style: TextStyle(
                    color: mainThemeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppListItem(Map app) {
    final usage = (app['usageStats']?[selectedFilter] ?? 0) as int;
    final percentage = totalUsage > 0 ? usage / totalUsage : 0.0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: homeController.imageFromBase64String(app['iconBase64']),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app['name'] ?? 'Unknown App',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    mainThemeColor.withOpacity(0.6)),
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            formatHoursMinutes(usage),
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(List<MapEntry<String, int>> categories) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    final nonEmptyCategories = categories.where((e) => e.value > 0).toList();

    if (nonEmptyCategories.isEmpty) {
      return Center(child: Text('No category data available'));
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "App Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...nonEmptyCategories.map((entry) => _buildCategoryItem(entry)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(MapEntry<String, int> entry) {
    final percentage = totalUsage > 0 
      ? (entry.value / totalUsage * 100).toStringAsFixed(0)
      : "0";
    
    return ListTile(
      leading: Icon(
        _getCategoryIcon(entry.key),
        color: mainThemeColor,
        size: 30,
      ),
      title: Text(
        entry.key,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        formatHoursMinutes(entry.value),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: mainThemeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "$percentage%",
          style: TextStyle(
            color: mainThemeColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}