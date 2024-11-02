import 'package:DevCodeX/components/compare_question_count.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:DevCodeX/services/cfdata.dart';
import 'package:DevCodeX/services/compare_chart_data.dart';
import 'package:flutter/material.dart';

class CompareCf extends StatelessWidget {
  const CompareCf({super.key});


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> d = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    CfData cfUser1 = d['cfDataUser1'] as CfData;
    CfData cfUser2 = d['cfDataUser2'] as CfData;
    List<ChartDataCompare> user1 = [
      ChartDataCompare('Easy', cfUser1.easySolved, Colors.green),
      ChartDataCompare('Medium', cfUser1.mediumSolved, Colors.yellowAccent),
      ChartDataCompare('Hard', cfUser1.hardSolved, Colors.red),
    ];
    List<ChartDataCompare> user2 = [
      ChartDataCompare('Easy', cfUser2.easySolved, Colors.green[700]!),
      ChartDataCompare('Medium', cfUser2.mediumSolved, Colors.yellow[700]!),
      ChartDataCompare('Hard', cfUser2.hardSolved, Colors.red[700]!)
    ];
    List<ChartDataCompare> contestUser1 = [
      ChartDataCompare('Max Rating', cfUser1.maxRating, Colors.green),
      ChartDataCompare(
          'Current Rating', cfUser1.userRating, Colors.yellowAccent),
    ];
    List<ChartDataCompare> contestUser2 = [
      ChartDataCompare('Max Rating', cfUser2.maxRating, Colors.green[700]!),
      ChartDataCompare(
          'Current Rating', cfUser2.userRating, Colors.yellow[700]!),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CompareQuestionCount(
                user1: user1,
                user2: user2,
                username1: cfUser1.username,
                username2: cfUser2.username,
              ),
              const SizedBox(height: 20),
              CompareQuestionCount(
                user1: contestUser1,
                user2: contestUser2,
                username1: cfUser1.username,
                username2: cfUser2.username,
              ),
            ],
          ),
        ));
  }
}
