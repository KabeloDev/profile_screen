import 'package:flutter/material.dart';
import 'package:profile_screen/Stats/activity.dart';
import 'package:profile_screen/Stats/post_engagement.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [
              EngagementChart(),
              SizedBox(height: 20,),
              ActivityChart(),
            ],
          ),
        ),
    );
  }
}
