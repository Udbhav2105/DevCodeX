import 'package:DevCodeX/services/chart_data_cf.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatefulWidget {
  final List<ChartDataCF> chartData;
  const DoughnutChart(this.chartData, {super.key});
  @override
  State<DoughnutChart> createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: SfCircularChart(
      tooltipBehavior: _tooltip,
      series: <CircularSeries<ChartDataCF, String>>[
      DoughnutSeries<ChartDataCF, String>(
      dataSource: widget.chartData,
      pointColorMapper: (ChartDataCF data, _) => data.color,
      xValueMapper: (ChartDataCF data, _) => data.x,
      yValueMapper: (ChartDataCF data, _) => data.y,
      dataLabelSettings: const DataLabelSettings(isVisible: true),
      radius: '80%', // Control the size of the chart
          ),
        ],
      ),
    );
  }
}