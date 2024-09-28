import 'dart:convert';

// import 'package:leetcode_unofficial_api/models/submit_stats.dart';
// import 'package:leetcode_unofficial_api/models/user_data.dart';
// import 'package:ripoff/services/user.dart';
// import 'package:leetcode_api_dart/leetcode_api_dart.dart';
// import 'package:leetcode_api_dart/models/problem.dart';
import 'package:http/http.dart';
import 'package:leetcode_unofficial_api/apis.dart';

import 'package:leetcode_unofficial_api/apis.dart';

// import 'package:leetcode_unofficial_api/models/lc_problem.dart';
import 'package:http/http.dart' as http;
import 'package:leetcode_unofficial_api/models/submit_stats.dart';
import 'package:leetcode_unofficial_api/models/user_badges/badges.dart';
import 'package:leetcode_unofficial_api/models/user_data.dart';

// import 'package:html/parser.dart' as htmlParser;

class Lc {
  late dynamic lcUsername;
  int easyCtn = 0;
  int mediumCtn = 0;
  int hardCtn = 0;
  int totalProblemCount = 0;
  int totalAcEasy = 0;
  int totalAcMedium = 0;
  int totalAcHard = 0;
  dynamic lcAvatar = 'https://assets.leetcode.com/users/default_avatar.jpg';
  late String daily;
  late dynamic userInfo;
  late dynamic problemCount;
  late dynamic questions;
  late bool lcAuth = false;
  List<String>? badgeUrls = [];
  late Map<String,dynamic> lcContest = {};
  Lc({required this.lcUsername});

  // Future<void> lcAuthenticate() async {
  //   print('initializing>....');
  //   try {
  //     lcAuth = true;
  //   } catch (e) {
  //     print("Error Fetching User Data");
  //     lcAuth = false;
  //   }
  // }

  // Future<void> fetchProblemCount() async {
  //   final response =
  //       await http.get(Uri.parse('https://leetcode.com/api/problems/all/'));
  //   // if (response.statusCode == 200){
  //   try {
  //     final data = jsonDecode(response.body);
  //     final problem = data['stat_status_pairs'];
  //
  //     for (var problem in problem) {
  //       final difficulty = problem['difficulty']['level'];
  //       if (difficulty == 1) {
  //         easyCtn++;
  //       } else if (difficulty == 2) {
  //         mediumCtn++;
  //       } else if (difficulty == 3) {
  //         hardCtn++;
  //       }
  //     }
  //     print('received graph data');
  //   } catch (e) {
  //     print("exception is $e");
  //   }
  // }

  Future<void> getData() async {
    try {
      await LeetCodeAPI.initializeApp(lcUsername);
      print('initializing>....');
      final userData = await LeetCodeAPI.instance.userData();
      final dailyProblem = await LeetCodeAPI.instance.dailyProblem();
      final solvedProblemCount =
      await LeetCodeAPI.instance.solvedProblemCount();
      final userBadges = await LeetCodeAPI.instance.userBadges();

      badgeUrls = userBadges?.badges.map((badge) {
        if (badge.icon != null && badge.icon.startsWith('/static')) {
          return 'https://leetcode.com${badge.icon}';
        } else {
          return badge.icon ?? ''; // Return icon or an empty string
        }
      }).toList();
      print('Badge URLs: $badgeUrls');
      lcUsername = userData?.username;
      totalAcEasy = solvedProblemCount!.totalEasySubmittedCount;
      totalAcMedium = solvedProblemCount.totalMediumSubmittedCount;
      totalAcHard = solvedProblemCount.totalHardSubmittedCount;
      totalProblemCount = solvedProblemCount.totalAcCount;
      lcAvatar = userData?.avatar;
      daily = dailyProblem.content;
      // problemCount = solvedProblemCount.;

      final response =
      await http.get(Uri.parse('https://leetcode.com/api/problems/all/'));
      final data = jsonDecode(response.body);
      final problem = data['stat_status_pairs'];

      for (var problem in problem) {
        final difficulty = problem['difficulty']['level'];
        if (difficulty == 1) {
          easyCtn++;
        } else if (difficulty == 2) {
          mediumCtn++;
        } else if (difficulty == 3) {
          hardCtn++;
        }
      }

      const String graphqlUrl = 'https://leetcode.com/graphql';
      final Map<String, dynamic> payload = {
        "query": """
        query getUserContestRanking(\$username: String!) {
          userContestRanking(username: \$username) {
            attendedContestsCount
            rating
            globalRanking
            totalParticipants
            topPercentage
            badge {
              name
            }
          }
        }
      """,
        "variables": {
          "username": lcUsername
        }
      };

      // Make the HTTP request for user contest ranking
      final constresponse = await http.post(
        Uri.parse(graphqlUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (constresponse.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(constresponse.body);
        final contestRanking = jsonResponse['data']['userContestRanking'];

        // Parsing the contest ranking data
        lcContest['Attended Contests:'] = contestRanking['attendedContestsCount'];
        lcContest['Rating: '] = contestRanking['rating'];
        lcContest['Global Ranking: '] = contestRanking['globalRanking'];
        lcContest['Top Percentage: '] = contestRanking['topPercentage'];
        print('contest data');
        print(lcContest);
      }
      else{
        print('tthere error is in contest data');
      }
      // print('received graph data');
      lcAuth = true;
    } catch (e) {
      print('Error encountered: $e');
      lcAuth = false;
    }
  }

  Future<void> fetchUserContestRanking() async {
  }

Future<void> getAllProblems() async {
  final String graphqlUrl = 'https://leetcode.com/graphql';
  final Map<String, dynamic> payload = {
    "query": """
        query problemsetQuestionList(\$categorySlug: String, \$limit: Int, \$skip: Int, \$filters: QuestionListFilterInput) {
          problemsetQuestionList: questionList(
            categorySlug: \$categorySlug
            limit: \$limit
            skip: \$skip
            filters: \$filters
          ) {
            total: totalNum
            questions: data {
              acRate
              difficulty
              freqBar
              frontendQuestionId: questionFrontendId
              isFavor
              paidOnly: isPaidOnly
              status
              title
              titleSlug
              topicTags {
                name
                id
                slug
              }
              hasSolution
              hasVideoSolution
            }
          }
        }
      """,
    "variables": {
      "categorySlug": "all-code-essentials",
      "limit": 50,
      "skip": 0,
      "filters": {}
    }
  };

  // Make the HTTP request
  final response = await http.post(
    Uri.parse(graphqlUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(payload),
  );

  // Handle the response
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    questions = jsonResponse['data']; // Store the response in data
  } else {
    print('Request failed with status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}}
