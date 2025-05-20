import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


void requestUsagePermission() {
  UsageStats.checkUsagePermission().then((isPermitted) {
    if (!isPermitted!) {
      UsageStats.grantUsagePermission();
    }
  });
}
  @override
  void initState() {
    // TODO: implement initState
    requestUsagePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('data'),
      ),
    );
  }
}