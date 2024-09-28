import 'package:flutter/material.dart';
import 'package:DevCodeX/components/contest_data.dart';
import 'package:DevCodeX/components/lc_badges_card.dart';
import 'package:DevCodeX/components/problem_count_card.dart';
import 'package:DevCodeX/components/username_avatar.dart';
import 'package:DevCodeX/components/radial_bargraph.dart';

class LeetcodePage extends StatelessWidget {
   LeetcodePage({super.key});

  Map<String,dynamic>d = {};

  // void setUpLeetcodePage(){
  @override
  Widget build(BuildContext context) {
    d = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
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
                chart: RadialBarChart(d['lcData'].totalAcEasy, d['lcData'].totalAcMedium,d['lcData'].totalAcHard),
                totalProblems: d['lcData'].totalProblemCount,
                easyCount: d['lcData'].totalAcEasy,
                mediumCount: d['lcData'].totalAcMedium,
                hardCount: d['lcData'].totalAcHard,
              ),
              BadgesCard(d['lcData'].badgeUrls),
              ContestCard(contestData:d['lcData'].lcContest),
            ],
          ),
      ),
      );
  }
}
