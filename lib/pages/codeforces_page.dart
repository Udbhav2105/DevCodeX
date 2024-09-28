import 'package:flutter/material.dart';
import 'package:ripoff/components/doughnut_chart.dart';
import 'package:ripoff/components/problem_count_card.dart';
import 'package:ripoff/components/username_avatar.dart';
import 'package:ripoff/services/chart_data_cf.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

class Codeforces extends StatefulWidget {
  const Codeforces({super.key});

  @override
  CodeforcesState createState() => CodeforcesState();
}

class CodeforcesState extends State<Codeforces> {
  Map d = {};
  // late TooltipBehavior _tooltip;
  late List<ChartDataCF> chartDataCF;

  @override
  void initState() {
    super.initState();
    // _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map;

    // Prepare chart data
    chartDataCF = [
      ChartDataCF('Easy (800-1300)', d['cfData'].easySolved ?? 0, Colors.green[300]!),
      ChartDataCF('Medium (1301-1900)', d['cfData'].mediumSolved ?? 0, Colors.orange),
      ChartDataCF('Hard (1901-2600)', d['cfData'].hardSolved ?? 0, Colors.red),
      ChartDataCF('Extreme (2601-3500)', d['cfData'].extremeSolved?? 0, Colors.purple),
      ChartDataCF('Unrated', d['cfData'].unratedSolved ?? 0, Colors.deepPurple),
    ];

    // return Scaffold(
    //   backgroundColor: Colors.black, // Dark background
    //   body: Padding(
    //     padding: const EdgeInsets.all(20.0),
    //     child: Column(
    //       children: [
    //         SafeArea(
    //           child: AvatarUsername(
    //             user: d['cfData'].username ?? 'User',
    //             avatar: d['cfData'].avatar ?? 'default_avatar_url', // Replace with your default avatar URL
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         Text(
    //           '${d['cfData'].username ?? 'Unknown User'}',
    //           style: const TextStyle(
    //             color: Color(0xFFD4AF37), // Gold color
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         Text(
    //           'Rating: ${d['cfData'].userRating ?? 'N/A'}',
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 18,
    //           ),
    //         ),
    //         Text(
    //           'Max Rating: ${d['cfData'].maxRating ?? 'N/A'}',
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 18,
    //           ),
    //         ),
    //         Text(
    //           'Rank: ${d['cfData'].rank ?? 'N/A'}',
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 18,
    //           ),
    //         ),
    //         Text(
    //           'Max Rank: ${d['cfData'].maxRank ?? 'N/A'}',
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 18,
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         Expanded(
    //           child: Card(
    //             color: const Color(0xFF1A1A1A), // Darker card background
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16),
    //             ),
    //             elevation: 10,
    //             child: SfCircularChart(
    //               tooltipBehavior: _tooltip,
    //               series: <CircularSeries<ChartData, String>>[
    //                 DoughnutSeries<ChartData, String>(
    //                   dataSource: chartData,
    //                   xValueMapper: (ChartData data, _) => data.x,
    //                   yValueMapper: (ChartData data, _) => data.y,
    //                   dataLabelSettings: const DataLabelSettings(isVisible: true),
    //                   radius: '80%', // Control the size of the chart
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      body: Column(
          children: [
            SafeArea(
              child: AvatarUsername(
                user: d['cfData'].username,
                avatar: d['cfData'].avatar,
              ),
            ),
            ProblemCountCard(
              chart: DoughnutChart(chartDataCF),
              totalProblems: d['cfData'].uniqueOkProblems.length,
              easyCount: d['cfData'].easySolved ?? 0,
              mediumCount: d['cfData'].mediumSolved ?? 0,
              hardCount: d['cfData'].hardSolved ?? 0,
              extremeCount1: d['cfData'].extremeSolved,
              extremeCountOneName: "Extreme",
              extremeCount2: d['cfData'].unratedSolved ?? 0,
              extremeCountTwoName: "Unrated",
            ),
          ],
        ),
    );
  }
}