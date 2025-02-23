import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Color palette
const Color primaryColor = Color(0xFF367bc1);
const Color lightBackgroundColor = Color(0xFFf2f3f9);
const Color darkPrimaryColor = Color(0xFF1c4c59);
const Color accentColor = Color(0xFF76b4b5);
const Color mediumGrayColor = Color(0xFFaab3bd);
const Color darkAccentColor = Color(0xFF2e535e);

void main() => runApp(MaterialApp(home: ChartPage()));

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int _selectedChart = 0; // 0 for daily, 1 for monthly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Stats'), backgroundColor: primaryColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SegmentedButton<int>(
              segments: const <ButtonSegment<int>>[
                ButtonSegment<int>(
                  value: 0,
                  label: Text('Daily Usage'),
                  icon: Icon(Icons.calendar_today),
                ),
                ButtonSegment<int>(
                  value: 1,
                  label: Text('Monthly Usage'),
                  icon: Icon(Icons.calendar_view_month),
                ),
              ],
              selected: <int>{_selectedChart},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  _selectedChart = newSelection.first;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child:
                  _selectedChart == 0 ? BarChartWidget() : StockChartWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, int> appUsageData = {
      'Instagram': 120,
      'Twitter': 90,
      'Facebook': 180,
      'YouTube': 240,
    };

    List<BarChartGroupData> barGroups =
        appUsageData.entries.map((entry) {
          String appName = entry.key;
          double timeSpentHours = entry.value / 60.0;
          double scaledTimeSpentHours = timeSpentHours * 3;

          return BarChartGroupData(
            x: appUsageData.keys.toList().indexOf(appName),
            barRods: [
              BarChartRodData(
                toY: scaledTimeSpentHours,
                color: primaryColor,
                width: 20,
                rodStackItems: [
                  BarChartRodStackItem(0, scaledTimeSpentHours, primaryColor),
                ],
                borderRadius: BorderRadius.zero,
              ),
            ],
          );
        }).toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'App Usage (Hours)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Center(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, titleMeta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${value.toInt()} hrs',
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            return Text(
                              appUsageData.keys.toList()[value.toInt()],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            );
                          },
                          reservedSize: 38,
                          interval: 1,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    gridData: FlGridData(show: false),
                    maxY: 12,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String appName =
                              appUsageData.keys.toList()[group.x.toInt()];
                          return BarTooltipItem(
                            '${rod.toY.toStringAsFixed(1)} hrs\n$appName',
                            TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StockChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, int> monthlyUsageData = {
      1: 15,
      2: 10,
      3: 5,
      4: 2,
      5: 8,
      6: 12,
      7: 9,
      8: 6,
      9: 11,
      10: 7,
      11: 8,
      12: 5,
    };

    List<FlSpot> spots =
        monthlyUsageData.entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.toDouble());
        }).toList();

    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'App Usage Over Time (Months)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Center(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, titleMeta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${value.toInt()} hrs',
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          },
                          interval: 5,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            return Text(monthNames[value.toInt() - 1]);
                          },
                          reservedSize: 38,
                          interval: 1,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    minY: 0,
                    maxY: 15,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: accentColor,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.yellow.withOpacity(0.3),
                        ),
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
