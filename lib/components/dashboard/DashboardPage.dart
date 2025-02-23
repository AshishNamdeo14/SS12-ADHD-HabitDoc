import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Define your color palette
const Color primaryColor = Color(0xFF367bc1);
const Color accentColor = Color(0xFF76b4b5);

void main() => runApp(MaterialApp(home: DashboardPage()));

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Stats'), backgroundColor: primaryColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarChartPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text(
                'Daily Usage',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StockChartPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text(
                'Weekly Usage',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartPage extends StatelessWidget {
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

    return Scaffold(
      appBar: AppBar(title: Text('Daily Usage')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                                  appUsageData.keys.toList()[group.x];
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
        ),
      ),
    );
  }
}

class StockChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, int> weeklyUsageData = {1: 15, 2: 10, 3: 5, 4: 2};

    List<FlSpot> spots =
        weeklyUsageData.entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.toDouble());
        }).toList();

    List<String> weekNames = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

    return Scaffold(
      appBar: AppBar(title: Text('Weekly Usage')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'App Usage Over Time (Weeks)',
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
                                    '${value.toInt()}',
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
                                return Text(weekNames[value.toInt() - 1]);
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
                            belowBarData: BarAreaData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}