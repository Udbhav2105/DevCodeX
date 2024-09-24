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
  Future<Map<String, int>> fetchCodeforcesData(String cfUsername) async {
    String urlStatus = 'https://codeforces.com/api/user.status?handle=$cfUsername';
    String urlInfo = 'https://codeforces.com/api/user.info?handles=$cfUsername&checkHistoricHandles=false';
    
    try {
      UnifiedApiResponse userInfo = await fetchData(urlInfo, 'userInfo');
      UnifiedApiResponse userStatus = await fetchData(urlStatus, 'userStatus');
      
      // Data calculation logic
      Set<String> uniqueOkProblems = {};
      int easySolved = 0;
      int mediumSolved = 0;
      int hardSolved = 0;
      int extremeSolved = 0;
      int unratedSolved = 0;

      for (var result in userStatus.result) {
        int? rating = result.problem.rating;
        if (result.verdict == Verdict.OK) {
          if (!uniqueOkProblems.contains(result.problem.name)) {
            uniqueOkProblems.add(result.problem.name);
            if (rating != null) {
              if (rating <= 1300) {
                easySolved++;
              } else if (rating <= 1900) {
                mediumSolved++;
              } else if (rating <= 2600) {
                hardSolved++;
              } else if (rating <= 3500) {
                extremeSolved++;
              }
            } else {
              unratedSolved++;
            }
          }
        }
      }

      // Return the calculated data as a map
      return {
        'easySolved': easySolved,
        'mediumSolved': mediumSolved,
        'hardSolved': hardSolved,
        'extremeSolved': extremeSolved,
        'unratedSolved': unratedSolved,
      };
    } catch (error) {
      print('Failed to fetch Codeforces data: $error');
      return {};
    }
  }

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
    await instance.authenticate();
    if (!instance.auth) {
      Navigator.pushNamed(context, '/');
    } else {
      await instance.getData();
      await instance.fetchProblemCount();
      
      // Pass both Leetcode and Codeforces data to the next page
      Navigator.pushReplacementNamed(context, '/leetcodePage', arguments: {
        'lcTotal': instance.problemCount.totalAcCount,
        'lcEasy': instance.problemCount.totalEasySubmittedCount,
        'lcMedium': instance.problemCount.totalMediumSubmittedCount,
        'lcHard': instance.problemCount.totalHardSubmittedCount,
        'lcUsername': lcUsername,
        'lcAvatar': instance.userInfo.username,
        'cfUsername': cfUsername,  
        // 'codeforcesData': codeforcesData, 
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

// Fetching data function (same as before)
Future<UnifiedApiResponse> fetchData(String url, String apiType) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return UnifiedApiResponse.fromJson(json.decode(response.body), apiType);
  } else {
    throw Exception('Failed to load data');
  }
}
