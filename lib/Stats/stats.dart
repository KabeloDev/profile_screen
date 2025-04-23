import 'package:flutter/material.dart';
import 'package:profile_screen/Stats/post_engagement.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stats'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: const [
          EngagementChart(),
        ],
      ),
      ),
    );
  }
}
