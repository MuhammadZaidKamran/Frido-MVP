import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frido_app/main.dart';
import 'package:usage_stats/usage_stats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UsageInfo> usageStats = [];
  List<AppInfo> installedApps = [];
  bool isLoading = true;
  String? errorMessage;
  String selectedPeriod = 'Daily';
  final List<String> periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await requestUsagePermission();
      await fetchInstalledApps();
      await fetchUsageData();
    } catch (e) {
      setState(() {
        errorMessage = "Initialization error: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  Future<void> requestUsagePermission() async {
    final isPermitted = await UsageStats.checkUsagePermission();
    if (!isPermitted!) {
      await UsageStats.grantUsagePermission();
    }
  }

  Future<void> fetchInstalledApps() async {
    try {
      final apps = await InstalledApps.getInstalledApps();
      setState(() => installedApps = apps);
    } catch (e) {
      throw Exception("Failed to fetch apps: ${e.toString()}");
    }
  }

  Future<void> fetchUsageData() async {
    try {
      final range = _getDateRange();
      final events = await UsageStats.queryUsageStats(range['start']!, range['end']!);
      
      final filteredEvents = events
          .where((info) => info.totalTimeInForeground != null)
          .toList()
        ..sort((a, b) => int.parse(b.totalTimeInForeground!)
            .compareTo(int.parse(a.totalTimeInForeground!)));
      
      setState(() {
        usageStats = filteredEvents;
        isLoading = false;
      });
    } catch (e) {
      throw Exception("Failed to fetch usage stats: ${e.toString()}");
    }
  }

  Map<String, DateTime?> _getDateRange() {
    final endDate = DateTime.now();
    switch (selectedPeriod) {
      case 'Weekly':
        return {'start': endDate.subtract(const Duration(days: 7)), 'end': endDate};
      case 'Monthly':
        return {'start': endDate.subtract(const Duration(days: 30)), 'end': endDate};
      case 'Yearly':
        return {'start': endDate.subtract(const Duration(days: 365)), 'end': endDate};
      default:
        return {'start': endDate.subtract(const Duration(days: 1)), 'end': endDate};
    }
  }

  Widget _buildAppIcon(AppInfo? app) {
    if (app == null || app.iconBase64.isEmpty) {
      return const Icon(Icons.apps, size: 40);
    }
    try {
      return Image.memory(
        base64Decode(app.iconBase64),
        width: 40,
        height: 40,
        errorBuilder: (_, __, ___) => const Icon(Icons.apps, size: 40),
      );
    } catch (e) {
      return const Icon(Icons.apps, size: 40);
    }
  }

  String _formatDuration(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) return "${hours}h ${minutes}m";
    if (duration.inMinutes > 0) return "${minutes}m";
    return "${duration.inSeconds}s";
  }

  String _formatHours(int milliseconds) {
    return (milliseconds / (60 * 60 * 1000)).toStringAsFixed(1);
  }

  AppInfo? _findAppInfo(String? packageName) {
    if (packageName == null) return null;
    return installedApps.firstWhere(
      (app) => app.packageName == packageName,
      orElse: () => AppInfo(
        name: packageName.split('.').last,
        packageName: packageName,
        iconBase64: '',
      ),
    );
  }

  List<UsageInfo> _getTopApps() {
    return usageStats
        .take(10)
        .where((stat) => _findAppInfo(stat.packageName)?.iconBase64.isNotEmpty ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final topApps = _getTopApps();

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Usage Analytics'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPeriod,
                icon: const Icon(Icons.arrow_drop_down),
                items: periods.map((period) => DropdownMenuItem(
                  value: period,
                  child: Text(period),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedPeriod = value;
                      isLoading = true;
                    });
                    fetchUsageData();
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(topApps),
    );
  }

  Widget _buildBody(List<UsageInfo> topApps) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage != null) return Center(child: Text(errorMessage!));
    if (topApps.isEmpty) return const Center(child: Text('No usage data available'));

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: topApps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) {
        final stat = topApps[index];
        final app = _findAppInfo(stat.packageName);
        final duration = int.parse(stat.totalTimeInForeground!);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildAppIcon(app),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app?.name ?? 'Unknown',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        _formatDuration(duration),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${_formatHours(duration)} hrs',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}