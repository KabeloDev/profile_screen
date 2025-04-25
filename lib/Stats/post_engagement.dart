import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EngagementChart extends StatelessWidget {
  const EngagementChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[90], 
      surfaceTintColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Radial gauge chart on the left
            SizedBox(
              height: 220,
              width: 220,
              child: SfRadialGauge(
                axes: [
                  // Background track for the chart
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 0,
                    endAngle: 360,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 30,
                      color: Colors.grey,
                    ),
                    pointers: const [
                      RangePointer(
                        value: 100, 
                        width: 30,
                        color: Colors.transparent,
                      ),
                    ],
                    annotations: [
                      // Icon annotation in the center of the chart
                      GaugeAnnotation(
                        widget: Icon(
                          Icons.mobile_friendly,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  // Segment for "Shares"
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 40,
                    endAngle: 120,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 30,
                      color: Colors.transparent,
                    ),
                    pointers: const [
                      RangePointer(
                        value: 100,
                        width: 30,
                        color: Colors.blue,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                  ),
                  // Segment for "Comments"
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 100,
                    endAngle: 220,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 30,
                      color: Colors.transparent,
                    ),
                    pointers: const [
                      RangePointer(
                        value: 100,
                        width: 30,
                        color: Colors.green,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                  ),
                  // Segment for "Likes"
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 200,
                    endAngle: 400,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 30,
                      color: Colors.transparent,
                    ),
                    pointers: const [
                      RangePointer(
                        value: 100,
                        width: 30,
                        color: Colors.orange,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20), 
            // Text description on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title for the engagement chart
                  Text(
                    'Post Engagement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Breakdown of engagement metrics
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Likes metric
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.orange),
                          const SizedBox(width: 8),
                          const Text('Likes: 75%'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Comments metric
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.green),
                          const SizedBox(width: 8),
                          const Text('Comments: 20%'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Shares metric
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text('Shares: 5%'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
