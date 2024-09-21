import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

enum Verdict {
  FAILED, OK, PARTIAL, COMPILATION_ERROR, RUNTIME_ERROR,
  WRONG_ANSWER, PRESENTATION_ERROR, TIME_LIMIT_EXCEEDED,
  MEMORY_LIMIT_EXCEEDED, IDLENESS_LIMIT_EXCEEDED, SECURITY_VIOLATED,
  CRASHED, INPUT_PREPARATION_CRASHED, CHALLENGED, SKIPPED,
  TESTING, REJECTED
}

enum Type { PROGRAMMING, QUESTION }

enum Testst {
  SAMPLES, PRETESTS, TESTS, CHALLENGES, TESTS1, TESTS2,
  TESTS3, TESTS4, TESTS5, TESTS6, TESTS7, TESTS8,
  TESTS9, TESTS10
}

enum ParticipantType { CONTESTANT, PRACTICE, VIRTUAL, GHOST } // Example participant types

class ApiResponse {
  final String status;
  final List<Result2> result;

  ApiResponse({required this.status, required this.result});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      result: (json['result'] as List)
          .map((item) => Result2.fromJson(item))
          .toList(),
    );
  }
}

class Result2 {
  final int id;
  final int contestId;
  final int creationTimeSeconds;
  final int relativeTimeSeconds;
  final Problem problem;
  final Party author;
  final String programmingLanguage;
  final Verdict? verdict; // Changed to Verdict enum
  final Testst testset; // Changed to Testst enum
  final int passedTestCount;
  final int timeConsumedMillis;
  final int memoryConsumedBytes;

  Result2({
    required this.id,
    required this.contestId,
    required this.creationTimeSeconds,
    required this.relativeTimeSeconds,
    required this.problem,
    required this.author,
    required this.programmingLanguage,
    this.verdict,
    required this.testset,
    required this.passedTestCount,
    required this.timeConsumedMillis,
    required this.memoryConsumedBytes,
  });

  factory Result2.fromJson(Map<String, dynamic> json) {
    return Result2(
      id: json['id'],
      contestId: json['contestId'],
      creationTimeSeconds: json['creationTimeSeconds'],
      relativeTimeSeconds: json['relativeTimeSeconds'],
      problem: Problem.fromJson(json['problem']),
      author: Party.fromJson(json['author']),
      programmingLanguage: json['programmingLanguage'],
      verdict: json['verdict'] != null ? Verdict.values.firstWhere((e) => e.toString().split('.').last == json['verdict']) : null,
      testset: Testst.values.firstWhere((e) => e.toString().split('.').last == json['testset']),
      passedTestCount: json['passedTestCount'],
      timeConsumedMillis: json['timeConsumedMillis'],
      memoryConsumedBytes: json['memoryConsumedBytes'],
    );
  }
}

class Problem {
  final int contestId;
  final String index;
  final String name;
  final Type type;
  final double? points;
  final int? rating;
  final List<String> tags;

  Problem({
    required this.contestId,
    required this.index,
    required this.name,
    required this.type,
    this.points,
    this.rating,
    required this.tags,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      contestId: json['contestId'],
      index: json['index'],
      name: json['name'],
      type: Type.values.firstWhere((e) => e.toString().split('.').last == json['type']),
      points: json['points']?.toDouble(),
      rating: json['rating'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class Party {
  final int? contestId;
  final List<Member> members;
  final ParticipantType participantType; // Changed to ParticipantType enum
  final bool ghost;
  final int? room;
  final int? startTimeSeconds;

  Party({
    this.contestId,
    required this.members,
    required this.participantType,
    required this.ghost,
    this.room,
    this.startTimeSeconds,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      contestId: json['contestId'],
      members: (json['members'] as List)
          .map((item) => Member.fromJson(item))
          .toList(),
      participantType: ParticipantType.values.firstWhere((e) => e.toString().split('.').last == json['participantType']),
      ghost: json['ghost'],
      room: json['room'],
      startTimeSeconds: json['startTimeSeconds'],
    );
  }
}

class Member {
  final String handle;
  final String? name;

  Member({
    required this.handle,
    this.name,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      handle: json['handle'],
      name: json['name'],
    );
  }
}

// Example function to fetch and parse the JSON data
Future<ApiResponse> fetchData(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

// Main function to test the parsing
void main() async {
  const url = 'https://codeforces.com/api/user.status?handle=vaibhavveerwaal'; // Replace with your API endpoint
  try {
    Set<String> uniqueOkProblems = {};
    int easySolved = 0;
    int mediumSolved = 0;
    int hardSolved = 0;
    int extremeSolved = 0;
    ApiResponse apiResponse = await fetchData(url);
    print('Status: ${apiResponse.status}');
    for (var result in apiResponse.result) {
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
        }
      }
      }
      print('Result ID: ${result.id}');
      print('Contest ID: ${result.contestId}');
      print('Problem Name: ${result.problem.name}');
      print('Verdict: ${result.verdict?.toString().split('.').last}');
      print('Testset: ${result.testset.toString().split('.').last}');
      print('Author: ${result.author.members.map((m) => m.handle).join(', ')}');
      print('---');
    }
    print("Unique problems solved: ${uniqueOkProblems.length}"); // this is the number of solved problems
    print("easy $easySolved medium $mediumSolved hard $hardSolved extreme $extremeSolved");

  } catch (e) {
    print('Error: $e');
  }
}
// To get - Number of solved questions --------- found == uniqueOkProblems.length
//        - Card with (image, max rating, max rank, current rating, contribution, friend count) ----------- already made in codeforces.dart
//        - solved questions according to difficulty: 800-1300 = easy, 1301-1900 = medium, 1901-2600 = hard, 2601-3500 = extreme ------- found in easySolved, mediumSolved, hardSolved and extremeSolved