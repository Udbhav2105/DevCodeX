import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ripoff/services/leetcode_api.dart';
import 'package:ripoff/services/codeforces_api.dart';
import 'package:ripoff/services/test.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};
  // Function to fetch Codeforces data using the provided username
  void setUpLeetcodeAndCodeforces() async {
    // Fetch the passed data from previous screen (Leetcode and Codeforces usernames)
    data = ModalRoute.of(context)?.settings.arguments as Map;
    String lcUsername = data['lcUsername'];
    String cfUsername = data['cfUsername']; // Get the Codeforces username

    // Fetch Codeforces data
    // Map<String, int> codeforcesData = await fetchCodeforcesData(cfUsername);
    CfData codeforcesData = CfData(username: cfUsername);
    await codeforcesData.fetchUserStatus();
    await codeforcesData.fetchUserInfo();

    // Fetch Leetcode data
    Lc instance = Lc(lcUsername: lcUsername);
    // await instance.lcAuthenticate();
    //   await instance.fetchProblemCount();
      await instance.getData();
    print('Lc Auth: ${instance.lcAuth}\n Cf Auth ${codeforcesData.cfAuth}');
    if (!instance.lcAuth && !codeforcesData.cfAuth) {
      Navigator.pushReplacementNamed(context, '/');
    } else if (instance.lcAuth && !codeforcesData.cfAuth) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'cfAuth': codeforcesData.cfAuth,
        'lcData' : instance
      });
    } else if (!instance.lcAuth && codeforcesData.cfAuth) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'cfAuth': codeforcesData.cfAuth,
        'cfUsername': cfUsername,
        'cfAvatar': codeforcesData.avatar,
        'cfRating': codeforcesData.userRating,
        'cfRank': codeforcesData.rank,
        'cfMaxRating': codeforcesData.maxRating,
        'cfMaxRank': codeforcesData.maxRank,
        'cfTotal': codeforcesData.uniqueOkProblems.length,
        'cfEasy': codeforcesData.easySolved,
        'cfMedium': codeforcesData.mediumSolved,
        'cfHard': codeforcesData.hardSolved,
        'cfExtreme': codeforcesData.extremeSolved,
        'cfUnrated': codeforcesData.unratedSolved,
        'lcData': instance,
      });
    } else {
      // Pass both Leetcode and Codeforces data to the next page
      Navigator.pushNamed(context, '/home', arguments: {
        // 'lcTotal': i
        'lcData':instance,
        // Codeforces Data :-
        'cfAuth': codeforcesData.cfAuth,
        'cfUsername': cfUsername,
        'cfAvatar': codeforcesData.avatar,
        'cfRating': codeforcesData.userRating,
        'cfRank': codeforcesData.rank,
        'cfMaxRating': codeforcesData.maxRating,
        'cfMaxRank': codeforcesData.maxRank,
        'cfTotal': codeforcesData.uniqueOkProblems.length,
        'cfEasy': codeforcesData.easySolved,
        'cfMedium': codeforcesData.mediumSolved,
        'cfHard': codeforcesData.hardSolved,
        'cfExtreme': codeforcesData.extremeSolved,
        'cfUnrated': codeforcesData.unratedSolved,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setUpLeetcodeAndCodeforces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF161616),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}

