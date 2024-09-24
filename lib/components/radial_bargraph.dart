import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ripoff/services/chart_data.dart';

class RadialBarChart extends StatefulWidget {
  final int easy;
  final int medium;
  final int hard;

  RadialBarChart(this.easy, this.medium, this.hard);

  @override
  State<RadialBarChart> createState() => _RadialBarChartState();
}

class _RadialBarChartState extends State<RadialBarChart> {
  String? extremeCountOneName;

  String? extremeCountTwoName;

  int? extremeCount1;

  int? extremeCount2;

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        "Hard",
        widget.hard.toDouble(),
        826,
        Colors.red,
      ),
      ChartData(
        'Medium',
        widget.medium.toDouble(),
        1726,
        Colors.orange,
      ),
      ChartData('Easy', widget.easy.toDouble(), 826, Colors.green[300]!),
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
}//