import 'package:flutter/material.dart';
import 'package:profile_screen/Stats/post_engagement.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  double _opacity = 0.0; // Initial opacity is 0 (fully transparent)

  @override
  void initState() {
    super.initState();
    // Trigger the fade-in effect after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0; // Set opacity to 1 (fully visible)
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: AnimatedOpacity(
        duration: const Duration(seconds: 2), // Duration of the fade-in effect
        opacity: _opacity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: const [
              EngagementChart(),
              SizedBox(height: 20,),
              
            ],
          ),
        ),
      ),
    );
  }
}
