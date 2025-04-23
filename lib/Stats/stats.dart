import 'package:flutter/material.dart';
import 'package:profile_screen/Stats/activity.dart';
import 'package:profile_screen/Stats/post_engagement.dart';
import 'package:profile_screen/Stats/profile_views.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {

  List<double> weeklyViews = [20, 45, 35, 16, 25, 17, 40];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                EngagementChart(),
                SizedBox(height: 20,),
                ActivityChart(),
                SizedBox(height: 20,),
                ProfileViews(profileViews: weeklyViews,),
                SizedBox(height: 50,),
              ],
            ),
          ),
      ),
    );
  }
}
