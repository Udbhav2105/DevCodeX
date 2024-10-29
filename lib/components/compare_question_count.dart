import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:DevCodeX/services/compare_chart_data.dart';

class CompareQuestionCount extends StatelessWidget {


  final List<ChartDataCompare> user1;
  final List<ChartDataCompare> user2;
  final String username1;
  final String username2;

  const CompareQuestionCount({super.key, required this.user1, required this.user2, required this.username1, required this.username2});

  @override
  Widget build(BuildContext context) {
    // List<ChartDataCompare> user1 = [
    //   ChartDataCompare('Easy', 72, Colors.green),
    //   ChartDataCompare('Medium', 53, Colors.yellowAccent),
    //   ChartDataCompare('Hard', 2, Colors.red),
    // ];

    // List<ChartDataCompare> user2 = [
    //   ChartDataCompare('Easy', 27, Colors.green[700]!),
    //   ChartDataCompare('Medium', 48, Colors.yellow[700]!),
    //   ChartDataCompare('Hard', 6, Colors.red[700]!)
    // ];

    return SizedBox(
      height: 300,
      width: 300,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<ChartDataCompare, String>>[
          ColumnSeries<ChartDataCompare, String>(
            name: username1,
            dataSource: user1,
            pointColorMapper: (ChartDataCompare data, _) => data.color,
            xValueMapper: (ChartDataCompare data, _) => data.type,
            yValueMapper: (ChartDataCompare data, _) => data.value,
          ),
          ColumnSeries<ChartDataCompare, String>(
            name: username2,
            dataSource: user2,
            pointColorMapper: (ChartDataCompare data, _) => data.color,
            xValueMapper: (ChartDataCompare data, _) => data.type,
            yValueMapper: (ChartDataCompare data, _) => data.value,
          ),
        ],
      ),
    );
  }
}