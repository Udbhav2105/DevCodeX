import 'package:DevCodeX/components/contest_data.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/components/doughnut_chart.dart';
import 'package:DevCodeX/components/problem_count_card.dart';
import 'package:DevCodeX/components/username_avatar.dart';
import 'package:DevCodeX/services/chart_data_cf.dart';
import 'package:DevCodeX/services/app_color.dart';

class Codeforces extends StatefulWidget {
  const Codeforces({super.key});

  @override
  CodeforcesState createState() => CodeforcesState();
}

class CodeforcesState extends State<Codeforces> {
  Map d = {};
  // late TooltipBehavior _tooltip;
  late List<ChartDataCF> chartDataCF;
  late Map<String, dynamic> contestData;

  @override
  void initState() {
    super.initState();
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
    contestData = {'Max Rating': d['cfData'].maxRating, 'Max Rank': d['cfData'].maxRank, 'Current Rating': d['cfData'].userRating, 'Current Rank': d['cfData'].rank};

    return Scaffold(
      backgroundColor:  AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
              ContestCard(contestData: contestData)
            ],
          ),
      ),
    );
  }
}