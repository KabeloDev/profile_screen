import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class ActivityChart extends StatelessWidget {
  const ActivityChart({super.key});

  // Weekly activity data points 
  final List<double> weeklyActivity = const [2, 4, 3, 6, 5, 7, 4];

  // Days of the week to display below the chart
  final List<String> daysOfWeek = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return Card(
      color: Colors.grey[90], 
      surfaceTintColor: Colors.grey[200],
      elevation: 1, 
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Weekly Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            // Line chart displaying weekly activity data
            SizedBox(
              height: 200,
              child: Sparkline(
                data: weeklyActivity,
                lineColor: Colors.blueAccent,
                pointsMode: PointsMode.none, 
                lineWidth: 2.5, 
              ),
            ),
            const SizedBox(height: 8),
            // Days of the week displayed below the chart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: daysOfWeek.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        color: modeController.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
