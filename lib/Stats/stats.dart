import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Stats Screen Content',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}