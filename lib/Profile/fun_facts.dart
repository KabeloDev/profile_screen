import 'package:flutter/material.dart';

class FunFactsSection extends StatelessWidget {
  final List<Map<String, dynamic>> funStats = [
    {
      'title': 'Projects Completed',
      'count': 12,
      'icon': Icons.build,
      'color': Colors.blue,
    },
    {
      'title': 'Certifications Earned',
      'count': 6,
      'icon': Icons.school,
      'color': Colors.green,
    },
    {
      'title': 'Cups of Coffee',
      'count': 350,
      'icon': Icons.local_cafe,
      'color': Colors.brown,
    },
    {
      'title': 'Days of Coding Streak',
      'count': 150,
      'icon': Icons.code,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const Text(
            'Fun Facts',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: funStats.length,
          itemBuilder: (context, index) {
            final stat = funStats[index];
            return Card(
              color: stat['color'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(stat['icon'], color: Colors.white, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      stat['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['count'].toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
