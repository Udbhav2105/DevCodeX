import 'package:flutter/material.dart';
import 'package:ripoff/components/username_avatar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ripoff/services/codeforces_api.dart';

class Codeforces extends StatefulWidget {
  const Codeforces({super.key});
  @override
  CodeforcesState createState() => CodeforcesState();
}

class CodeforcesState extends State<Codeforces> {
  Map d = {};
  late TooltipBehavior _tooltip;
  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map;
    chartData = [
      ChartData('Easy (800-1300)', d['cfEasy']),
      ChartData('Medium (1301-1900)', d['cfMedium']),
      ChartData('Hard (1901-2600)', d['cfHard']),
      ChartData('Extreme (2601-3500)', d['cfExtreme']),
      ChartData('Unrated', d['cfUnrated']),
    ];
    return Column(
      children: [
        SafeArea(
            child: CircleAvatar(
          backgroundImage: NetworkImage(d['cfAvatar']),
          radius: 50,
        )),
        const SizedBox(
          height: 10,
        ),
        Text('${d['cfUsername']}'),
        Text('Rating: ${d['cfRating']}'),
        Text('Max Rating: ${d['cfMaxRating']}'),
        Text('Rank: ${d['cfRank']}'),
        Text('Max Rank: ${d['cfMaxRank']}'),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SfCircularChart(
            tooltipBehavior: _tooltip,
            series: <CircularSeries<ChartData, String>>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Model class for chart data
class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int y;
}

Future<UnifiedApiResponse> fetchData(String url, String apiType) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return UnifiedApiResponse.fromJson(json.decode(response.body), apiType);
  } else {
    throw Exception('Failed to load data');
  }
}
