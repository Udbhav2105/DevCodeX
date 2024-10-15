import 'package:DevCodeX/components/contest_data.dart';
import 'package:DevCodeX/components/doughnut_chart.dart';
import 'package:DevCodeX/services/chart_data_cf.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/components/problem_count_card.dart';
import 'package:DevCodeX/components/username_avatar.dart';
import 'package:DevCodeX/services/app_color.dart';

class Geeksforgeeks extends StatefulWidget {
  const Geeksforgeeks({super.key});

  @override
  GeeksforgeeksState createState() => GeeksforgeeksState();
}

class GeeksforgeeksState extends State<Geeksforgeeks> {
  Map d = {};

  late List<ChartDataCF> chartDataGfg;
  late Map<String, dynamic> contestdataGfg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map;

    // Prepare chart data
    chartDataGfg = [
      ChartDataCF('Easy', d['gfgData'].easy, Colors.green[300]!),
      ChartDataCF('Medium', d['gfgData'].medium, Colors.orange),
      ChartDataCF('Hard', d['gfgData'].hard, Colors.red),
      ChartDataCF('Basic', d['gfgData'].basic, Colors.purple),
      ChartDataCF('School', d['gfgData'].school, Colors.deepPurple),
    ];

    contestdataGfg = {
      'Institution': d['gfgData'].institution,
      'Institute Rank': d['gfgData'].instituteRank,
      'Languages Used': d['gfgData'].languagesUsed,
      'Coding Score': d['gfgData'].codingScore,
      'Articles Published': d['gfgData'].articlesPublished,
      'Current Streak': d['gfgData'].currentStreak,
    };

    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: AvatarUsername(
                    user: d['gfgData'].userName, avatar: d['gfgData'].avatar),
              ),
              ProblemCountCard(
                totalProblems: d['gfgData'].totalProblemsSolved,
                easyCount: d['gfgData'].easy,
                mediumCount: d['gfgData'].medium,
                hardCount: d['gfgData'].hard,
                chart: DoughnutChart(chartDataGfg),
                extremeCount1: d['gfgData'].school,
                extremeCountOneName: "School",
                extremeCount2: d['gfgData'].basic,
                extremeCountTwoName: "Basic",
              ),
              ContestCard(contestData: contestdataGfg),
            ],
          ),
        ));
  }
}
