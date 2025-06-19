import 'package:flutter/material.dart';
import 'package:frido_app/Controller/permission_controllers.dart';
import 'package:frido_app/Global/colors.dart';
import 'package:frido_app/View/BottomNavigationBar/Home/home_view.dart';
import 'package:frido_app/View/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:get/get.dart';

class UsagePermissionScreen extends StatefulWidget {
  const UsagePermissionScreen({super.key});

  @override
  State<UsagePermissionScreen> createState() => _UsagePermissionScreenState();
}

class _UsagePermissionScreenState extends State<UsagePermissionScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    setState(() => _isLoading = true);
    final isGranted = await PermissionControllers.isUsagePermissionGranted();
    setState(() => _isLoading = false);
    
    if (isGranted && mounted) {
      Get.off(() => const BottomNavigationBarView());
    }
  }

  Future<void> _requestPermission() async {
    setState(() => _isLoading = true);
    await PermissionControllers.openUsageSettings();
    await _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F9FF), Color(0xFFEFF2FF)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Icon
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        mainThemeColor.withOpacity(0.1),
                        Colors.purple.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.insights_rounded,
                    size: 60,
                    color: mainThemeColor,
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  "Screen Time Access",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: mainThemeColor,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "To show your app usage stats, we need screen time permission",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Key Benefit
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: mainThemeColor,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Get personalized insights",
                        style: TextStyle(
                          color: mainThemeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Permission button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _requestPermission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainThemeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "ALLOW ACCESS",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}