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
            // Chart on the left
            SizedBox(
              height: 220,
              width: 220,
              child: SfRadialGauge(
                axes: [
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
                        value: 100, // full background track
                        width: 30,
                        color: Colors.transparent,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Icon(
                          Icons.mobile_friendly,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
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
            const SizedBox(width: 20), // Space between chart and text
            // Text on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Engagement',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Likes: 75%'),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Container(width: 12, height: 12, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Comments: 20%'),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 8),
                          Text('Shares: 5%'),
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
