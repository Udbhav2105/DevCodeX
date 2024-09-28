import 'package:flutter/material.dart';
import 'package:ripoff/components/contest_data.dart';
import 'package:ripoff/components/lc_badges_card.dart';
import 'package:ripoff/components/problem_count_card.dart';
import 'package:ripoff/components/username_avatar.dart';
import 'package:ripoff/components/radial_bargraph.dart';

class LeetcodePage extends StatefulWidget {
  const LeetcodePage({super.key});

  @override
  State<LeetcodePage> createState() => _LeetcodePageState();
}

class _LeetcodePageState extends State<LeetcodePage> {
  Map<String,dynamic>d = {};
  // void setUpLeetcodePage(){

  // }
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero,(){
  //     setUpLeetcodePage();
  //   });
  //
  // }
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
