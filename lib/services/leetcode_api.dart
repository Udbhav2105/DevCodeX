import 'dart:convert';
// import 'package:leetcode_unofficial_api/models/submit_stats.dart';
// import 'package:leetcode_unofficial_api/models/user_data.dart';
// import 'package:ripoff/services/user.dart';
// import 'package:leetcode_api_dart/leetcode_api_dart.dart';
// import 'package:leetcode_api_dart/models/problem.dart';
import 'package:leetcode_unofficial_api/apis.dart';
// import 'package:leetcode_unofficial_api/models/lc_problem.dart';
import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as htmlParser;

class lc {
  late dynamic userInfo;
  late dynamic stats;
  late String url;
  late String daily;
  late dynamic problemCount;
  late dynamic questions;

  lc({required this.url});

  Future<void> getData() async {
    await LeetCodeAPI.initializeApp('Va1bhav_512');

    final userData = await LeetCodeAPI.instance.userData();
    final dailyProblem = await LeetCodeAPI.instance.dailyProblem();
    final solvedProblemCount = await LeetCodeAPI.instance.solvedProblemCount();
    // final recentSubmissions = await LeetCodeAPI.instance.recentSubmissions();

    userInfo = userData;
    problemCount = solvedProblemCount;
    daily = dailyProblem.content;

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
}
