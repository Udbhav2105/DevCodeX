import 'package:flutter/material.dart';
import 'package:ripoff/components/problem_count_card.dart';
import 'package:ripoff/components/username_avatar.dart';
import 'package:ripoff/components/radial_bargraph.dart';

class LeetcodePage extends StatefulWidget {
  const LeetcodePage({super.key});

  @override
  State<LeetcodePage> createState() => _LeetcodePageState();
}

class _LeetcodePageState extends State<LeetcodePage> {
  Map d = {};
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
    d = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: const Color(0xFF161616),
      body: Column(
        children: [
          SafeArea(
            child: AvatarUsername(
              user: d['lcUsername'],
            ),
          ),
          ProblemCountCard(
            // why this taking too long? its yesp
            totalProblems: d['lcTotal'],
            easyCount: d['lcEasy'],
            mediumCount: d['lcMedium'],
            hardCount: d['lcHard'],
          ),
        ],
      ),
    );;
  }
}
