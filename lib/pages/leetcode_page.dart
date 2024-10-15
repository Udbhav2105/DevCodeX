import 'package:flutter/material.dart';
import 'package:DevCodeX/components/contest_data.dart';
import 'package:DevCodeX/components/lc_badges_card.dart';
import 'package:DevCodeX/components/problem_count_card.dart';
import 'package:DevCodeX/components/username_avatar.dart';
import 'package:DevCodeX/components/radial_bargraph.dart';
import 'package:DevCodeX/services/app_color.dart';

class LeetcodePage extends StatelessWidget {
  LeetcodePage({super.key});

  Map<String, dynamic> d = {};

  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,iconTheme: const IconThemeData(color: Colors.white),),
      backgroundColor:  AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AvatarUsername(
                user: d['lcData'].lcUsername,
                avatar: d['lcData'].lcAvatar,
              ),
            ),
            ProblemCountCard(
              chart: RadialBarChart(
                  d['lcData'].totalAcEasy,
                  d['lcData'].totalAcMedium,
                  d['lcData'].totalAcHard,
                  d['lcData'].easyCtn,
                  d['lcData'].mediumCtn,
                  d['lcData'].hardCtn),
              totalProblems: d['lcData'].totalProblemCount,
              easyCount: d['lcData'].totalAcEasy,
              mediumCount: d['lcData'].totalAcMedium,
              hardCount: d['lcData'].totalAcHard,
            ),
            BadgesCard(d['lcData'].badgeUrls),
            ContestCard(contestData: d['lcData'].lcContest),
          ],
        ),
      ),
    );
  }
}
