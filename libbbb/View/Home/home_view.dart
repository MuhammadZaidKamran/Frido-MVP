import 'package:flutter/material.dart';
import 'package:frido_app/Controller/home_controller.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Usage Stats'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Filter buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                filterButton('Daily'),
                filterButton('Weekly'),
                filterButton('Monthly'),
                // filterButton('Yearly'),
              ],
            ),
            const SizedBox(height: 20),

            // Content area
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : appsStats.isEmpty
                      ? const Center(child: Text('No data available'))
                      : ListView.separated(
                          itemCount: appsStats.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final app = appsStats[index];
                            return ListTile(
                              leading: homeController.imageFromBase64String(app['iconBase64']),
                              title: Text(app['name'] ?? 'Unknown App'),
                              trailing: Text(homeController.formatDurationFromMillis(app['usageStats']?[selectedFilter] ?? 0)),

                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}
