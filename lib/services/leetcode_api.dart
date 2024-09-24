import 'dart:convert';

// import 'package:leetcode_unofficial_api/models/submit_stats.dart';
// import 'package:leetcode_unofficial_api/models/user_data.dart';
// import 'package:ripoff/services/user.dart';
// import 'package:leetcode_api_dart/leetcode_api_dart.dart';
// import 'package:leetcode_api_dart/models/problem.dart';
import 'package:leetcode_unofficial_api/apis.dart';

// import 'package:leetcode_unofficial_api/models/lc_problem.dart';
import 'package:http/http.dart' as http;
import 'package:leetcode_unofficial_api/models/submit_stats.dart';
import 'package:leetcode_unofficial_api/models/user_data.dart';

// import 'package:html/parser.dart' as htmlParser;
import 'package:ripoff/services/user.dart';
import 'package:ripoff/services/SubmitStats.dart';

class Lc {
  int easyCtn = 0;
  int mediumCtn = 0;
  int hardCtn = 0;
  late dynamic userInfo;
  // late dynamic stats;
  late String lcUsername;
  late String daily;
  late dynamic problemCount;
  late dynamic questions;
  late bool lcAuth = false;

  Lc({required this.lcUsername});

  Future<void> lcAuthenticate() async {
    print('initializing>....');
    try {
      await LeetCodeAPI.initializeApp(lcUsername);
      lcAuth = true;
    } catch (e) {
      print("Error Fetching User Data");
      lcAuth = false;
    }
  }

  Future<void> fetchProblemCount() async {
    final response =
        await http.get(Uri.parse('https://leetcode.com/api/problems/all/'));
    // if (response.statusCode == 200){
    try {
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
      print('received graph data');
      lcAuth = true;
    }
    catch (e) {
      print("exception is $e");
      lcAuth = false;
    }
  }

  Future<void> getData() async {
    // if (lcAuth == false) {
    //   print("User not Authenticated");
    //   return;
    // }
    try {
      final userData = await LeetCodeAPI.instance.userData();
      final dailyProblem = await LeetCodeAPI.instance.dailyProblem();
      final solvedProblemCount =
          await LeetCodeAPI.instance.solvedProblemCount();
      userInfo = userData;
      problemCount = solvedProblemCount;
      daily = dailyProblem.content;
      lcAuth = true;
    } catch (e) {
      print('Error is encountered ${e}');
      lcAuth = false;
    }
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
  }
}
