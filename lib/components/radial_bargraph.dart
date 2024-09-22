import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ripoff/services/chart_data.dart';

class RadialBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData("Hard",1, 826,Colors.red,),
      ChartData('Medium', 44, 1726,Colors.orange,),
      ChartData('Easy', 25, 826,Colors.green[300]!),
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
              return (percentage < 5 && percentage > 0)? 5 : percentage; // Minimum 5% fill
            },
            pointColorMapper: (ChartData data, _) => data.color,
            maximumValue: 100,
            radius: '100%',
            innerRadius: '25%',
            gap: '15%',
            trackBorderWidth: 5,
            cornerStyle: CornerStyle.bothCurve,
            ),
        ],
      ),
    );
  }
}
