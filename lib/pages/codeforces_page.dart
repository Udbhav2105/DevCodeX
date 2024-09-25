import 'package:flutter/material.dart';
import 'package:ripoff/components/username_avatar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

    // Prepare chart data
    chartData = [
      ChartData('Easy (800-1300)', d['cfEasy'] ?? 0),
      ChartData('Medium (1301-1900)', d['cfMedium'] ?? 0),
      ChartData('Hard (1901-2600)', d['cfHard'] ?? 0),
      ChartData('Extreme (2601-3500)', d['cfExtreme'] ?? 0),
      ChartData('Unrated', d['cfUnrated'] ?? 0),
    ];

    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SafeArea(
              child: AvatarUsername(
                user: d['cfUsername'] ?? 'User',
                avatar: d['cfAvatar'] ?? 'default_avatar_url', // Replace with your default avatar URL
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${d['cfUsername'] ?? 'Unknown User'}',
              style: const TextStyle(
                color: Color(0xFFD4AF37), // Gold color
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rating: ${d['cfRating'] ?? 'N/A'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Max Rating: ${d['cfMaxRating'] ?? 'N/A'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Rank: ${d['cfRank'] ?? 'N/A'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Max Rank: ${d['cfMaxRank'] ?? 'N/A'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: const Color(0xFF1A1A1A), // Darker card background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 10,
                child: SfCircularChart(
                  tooltipBehavior: _tooltip,
                  series: <CircularSeries<ChartData, String>>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      radius: '80%', // Control the size of the chart
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for chart data
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}
