import 'package:DevCodeX/components/compare_question_count.dart';
import 'package:DevCodeX/services/leetcode_api.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:DevCodeX/services/compare_chart_data.dart';

class CompareLeetcode extends StatelessWidget {
  CompareLeetcode({super.key});
  
  Map<String, dynamic> d = {};

  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Lc lcUser1 = d['lcDataUser1'] as Lc;
    Lc lcUser2 = d['lcDataUser2'] as Lc;
    List<ChartDataCompare> user1 = [
      ChartDataCompare('Easy', lcUser1.totalAcEasy, Colors.green),
      ChartDataCompare('Medium', lcUser1.totalAcMedium, Colors.yellowAccent),
      ChartDataCompare('Hard', lcUser1.totalAcHard, Colors.red),
    ];
    List<ChartDataCompare> user2 = [
      ChartDataCompare('Easy', lcUser2.totalAcEasy, Colors.green[700]!),
      ChartDataCompare('Medium', lcUser2.totalAcMedium, Colors.yellow[700]!),
      ChartDataCompare('Hard', lcUser2.totalAcHard, Colors.red[700]!)
    ];
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CompareQuestionCount(user1: user1, user2: user2, username1: lcUser1.lcUsername,username2: lcUser2.lcUsername,),
          ],
        ),  
      )
    );
  }
}