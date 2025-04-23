import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class ProfileViews extends StatelessWidget {
  final List<double> profileViews;

  const ProfileViews({super.key, required this.profileViews});

  @override
  Widget build(BuildContext context) {

    final modeController = Provider.of<ModeController>(context);
    
    IndividualBarData barData = IndividualBarData(
      monViews: profileViews[0],
      tueViews: profileViews[1],
      wedViews: profileViews[2],
      thuViews: profileViews[3],
      friViews: profileViews[4],
      satViews: profileViews[5],
      sunViews: profileViews[6],
    );

    return Card(
      color: Colors.grey[90],
      surfaceTintColor: Colors.grey[200],
      elevation: 1,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Profile Views',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: getBottomTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups:
                      barData.bars
                          .map(
                            (data) => BarChartGroupData(
                              x: data.x,
                              barRods: [
                                BarChartRodData(
                                  toY: data.y,
                                  color: Colors.blueAccent,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(6),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 100,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        days[value.toInt()],
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
    );
  }
}

class BarData {
  final int x;
  final double y;

  BarData({required this.x, required this.y});
}

class IndividualBarData {
  final double monViews;
  final double tueViews;
  final double wedViews;
  final double thuViews;
  final double friViews;
  final double satViews;
  final double sunViews;

  IndividualBarData({
    required this.monViews,
    required this.tueViews,
    required this.wedViews,
    required this.thuViews,
    required this.friViews,
    required this.satViews,
    required this.sunViews,
  });

  List<BarData> get bars => [
    BarData(x: 0, y: monViews),
    BarData(x: 1, y: tueViews),
    BarData(x: 2, y: wedViews),
    BarData(x: 3, y: thuViews),
    BarData(x: 4, y: friViews),
    BarData(x: 5, y: satViews),
    BarData(x: 6, y: sunViews),
  ];
}
