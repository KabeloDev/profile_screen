import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double initialProgress; // Initial progress value (0 to 1)
  const ProgressBar({super.key, required this.initialProgress});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late double progress; // Current progress value

  @override
  void initState() {
    super.initState();
    progress = widget.initialProgress; // Initialize progress with the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar with animation
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: progress),
            duration: const Duration(milliseconds: 500),
            builder: (context, double value, child) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    width: value * MediaQuery.of(context).size.width,
                    height: 20,
                    decoration: BoxDecoration(
                      color: value == 1.0 ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${(value * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // Label or Icon based on progress
          if (progress == 1.0)
            const Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 40,
              ),
            ),
          const SizedBox(height: 10),
          // Optional: Milestone Label
          Center(
            child: Text(
              progress == 1.0 ? 'Goal Achieved!' : 'In Progress...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: progress == 1.0 ? Colors.green : Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Slider to adjust progress
          Slider(
            value: progress,
            onChanged: (newValue) {
              setState(() {
                progress = newValue; // Update progress value
              });
            },
            min: 0.0,
            max: 1.0,
            divisions: 100, // Optional: Divide the slider into 100 steps
            label: '${(progress * 100).toInt()}%', // Show percentage as a label
          ),
        ],
      ),
    );
  }
}
