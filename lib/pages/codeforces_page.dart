import 'package:flutter/material.dart';
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
  late final String username;
  late Future<UnifiedApiResponse> futureUser;
  late Future<UnifiedApiResponse> futureUser2;
  late TooltipBehavior _tooltip;
  late List<ChartData> chartData;

  @override
  void initState() {
    super.initState();
    String urlStatus = 'https://codeforces.com/api/user.status?handle=vaibhavveerwaal';
    String urlInfo = 'https://codeforces.com/api/user.info?handles=vaibhavveerwaal&checkHistoricHandles=false';
    futureUser = fetchData(urlInfo, 'userInfo');
    futureUser2 = fetchData(urlStatus, 'userStatus');

    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Codeforces')),
      body: Center(
        child: FutureBuilder(
          future: Future.wait([futureUser, futureUser2]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userInfo = snapshot.data![0];
              final userStatus = snapshot.data![1];
              final result = userInfo.result[0];

              // Data calculation logic
              Set<String> uniqueOkProblems = {};
              int easySolved = 0;
              int mediumSolved = 0;
              int hardSolved = 0;
              int extremeSolved = 0;
              int unratedSolved = 0;

              for (var result in userStatus.result) {
                int? rating = result.problem.rating;
                if (result.verdict == Verdict.OK) {
                  if (!uniqueOkProblems.contains(result.problem.name)) {
                    uniqueOkProblems.add(result.problem.name);
                    if (rating != null) {
                      if (rating <= 1300) {
                        easySolved++;
                      } else if (rating <= 1900) {
                        mediumSolved++;
                      } else if (rating <= 2600) {
                        hardSolved++;
                      } else if (rating <= 3500) {
                        extremeSolved++;
                      }
                    } else {
                      unratedSolved++;
                    }
                  }
                }
              }

              // Prepare data for doughnut chart
              chartData = [
                ChartData('Easy (800-1300)', easySolved),
                ChartData('Medium (1301-1900)', mediumSolved),
                ChartData('Hard (1901-2600)', hardSolved),
                ChartData('Extreme (2601-3500)', extremeSolved),
                ChartData('Unrated', unratedSolved),
              ];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(result.avatar),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Text('${result.handle}'),
                  Text('Rating: ${result.rating}'),
                  Text('Rank: ${result.rank}'),
                  const SizedBox(height: 20),
                  
                  // Add doughnut chart
                  Expanded(
                    child: SfCircularChart(
                      tooltipBehavior: _tooltip,
                      series: <CircularSeries<ChartData, String>>[
                        DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:const DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
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

Future<UnifiedApiResponse> fetchData(String url, String apiType) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return UnifiedApiResponse.fromJson(json.decode(response.body), apiType);
  } else {
    throw Exception('Failed to load data');
  }
}
