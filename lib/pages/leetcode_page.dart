import 'package:DevCodeX/services/leetcode_api.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/components/contest_data.dart';
import 'package:DevCodeX/components/lc_badges_card.dart';
import 'package:DevCodeX/components/problem_count_card.dart';
import 'package:DevCodeX/components/username_avatar.dart';
import 'package:DevCodeX/components/radial_bargraph.dart';
import 'package:DevCodeX/services/app_color.dart';

class LeetcodePage extends StatelessWidget {
  const LeetcodePage({super.key});


  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> d = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Lc lcData = d['lcData'] as Lc;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
      backgroundColor:  AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AvatarUsername(
                user: lcData.lcUsername,
                avatar: lcData.lcAvatar,
              ),
            ),
            ProblemCountCard(
              chart: RadialBarChart(
                  lcData.totalAcEasy,
                  lcData.totalAcMedium,
                  lcData.totalAcHard,
                  lcData.easyCtn,
                  lcData.mediumCtn,
                  lcData.hardCtn),
              totalProblems: lcData.totalProblemCount,
              easyCount: lcData.totalAcEasy,
              mediumCount: lcData.totalAcMedium,
              hardCount: lcData.totalAcHard,
            ),
            BadgesCard(lcData.badgeUrls ?? []),
            ContestCard(contestData: lcData.lcContest),
          ],
        ),
      ),
    );
  }
}
