import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FunFactsSection extends StatefulWidget {
  const FunFactsSection({super.key});

  @override
  State<FunFactsSection> createState() => _FunFactsSectionState();
}

class _FunFactsSectionState extends State<FunFactsSection> {
  bool _isVisible = false; // Controls the visibility of the section

  // List of fun facts with their titles, counts, icons, and colors
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
    return VisibilityDetector(
      key: const Key('fun-facts-section'),
      onVisibilityChanged: (info) {
        // Trigger animation when the section becomes visible
        if (info.visibleFraction > 0.4 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
        // Reset animation when the section is scrolled out of view
        if (info.visibleFraction == 0 && _isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Fun Facts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          // Animated grid of fun facts
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0, // Fade in when visible
            duration: const Duration(seconds: 1),
            child: GridView.builder(
              shrinkWrap: true, // Prevents the grid from expanding infinitely
              physics: const NeverScrollableScrollPhysics(), // Disables scrolling within the grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns in the grid
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
                    padding: const EdgeInsets.all(8.0),
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
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        // Animated counter for the fun fact count
                        _isVisible
                            ? TweenAnimationBuilder(
                                tween: IntTween(begin: 0, end: stat['count']),
                                duration: const Duration(seconds: 2),
                                builder: (context, value, child) => Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                '0', // Default value when not visible
                                style: TextStyle(
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
          ),
        ],
      ),
    );
  }
}
