import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ripoff/services/chart_data.dart';

class RadialBarChart extends StatelessWidget {
  final int easy;
  final int medium;
  final int hard;
  String? extremeCountOneName;
  String? extremeCountTwoName;
  int? extremeCount1;
  int? extremeCount2;

  RadialBarChart(this.easy, this.medium, this.hard);

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        "Hard",
        hard.toDouble(),
        826,
        Colors.red,
      ),
      ChartData(
        'Medium',
        medium.toDouble(),
        1726,
        Colors.orange,
      ),
      ChartData('Easy', easy.toDouble(), 826, Colors.green[300]!),
    ];

    return Container(
      height: 200, // Set a specific height for the chart
      width: 200,
      child: SfCircularChart(
        backgroundColor: Colors.transparent,
        series: <CircularSeries>[
          RadialBarSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) {
              double percentage = (data.solved / data.total) * 100;
              return (percentage < 5 && percentage > 0)
                  ? 5
                  : percentage; // Minimum 5% fill
            },
            pointColorMapper: (ChartData data, _) => data.color,
            maximumValue: 100,
            radius: '100%',
            innerRadius: '20%',
            gap: '12%',
            trackBorderWidth: 7,
            cornerStyle: CornerStyle.bothFlat,
          ),
        ],
      ),
    );
  }
}
