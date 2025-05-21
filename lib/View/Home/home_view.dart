import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frido_app/Controller/home_controller.dart';
import 'package:frido_app/Global/global.dart';
import 'package:frido_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeControllers homeController = HomeControllers();
 List<Map> appsStats = [] ;
 bool isLoading = true;

 void fetchAppStats()async{
  isLoading = true;
  appsStats = await homeController.getAppStats();
  
  if(appsStats != null){
    isLoading = false;
  }
  setState(() {});
 }
  


  @override
  void initState() {
    fetchAppStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child:ListView.separated(itemCount: appsStats.length, separatorBuilder: (context, index) => myHeight(0.03),itemBuilder: (context, index) {
          Map app = appsStats[index];
          return ListTile(
            title: Text(app['name']),
            trailing: Text(homeController.formatDurationFromMillis(app['usageTime'])),
            leading: homeController.imageFromBase64String(app['iconBase64']),
            );
        },)
      )
    );
  }
}
