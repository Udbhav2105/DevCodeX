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

class UnifiedApiResponse {
  final String status;
  final List<dynamic> result;

  UnifiedApiResponse({required this.status, required this.result});

  factory UnifiedApiResponse.fromJson(Map<String, dynamic> json, String apiType) {
    if (apiType == 'userStatus') {
      return UnifiedApiResponse(status: json['status'], result: (json['result'] as List).map((item) => Result2.fromJson(item)).toList());
    } else if (apiType == 'userInfo') {
      return UnifiedApiResponse(status: json['status'], result: (json['result'] as List).map((item) => Result.fromJson(item)).toList());
    } else {
      throw Exception('Unknown API type');
    }
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
Future<UnifiedApiResponse> fetchData(String url, String apiType) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return UnifiedApiResponse.fromJson(json.decode(response.body), apiType);
  } else {
    throw Exception('Failed to load data');
  }
}
class Result {
    final int contribution;
    final int lastOnlineTimeSeconds;
    final int rating;
    final int friendOfCount;
    final String titlePhoto;
    final String rank;
    final String handle;
    final int maxRating;
    final String avatar;
    final int registrationTimeSeconds;
    final String maxRank;
    Result({
      required this.contribution,
      required this.lastOnlineTimeSeconds,
      required this.avatar,
      required this.friendOfCount,
      required this.handle,
      required this.maxRank,
      required this.maxRating,
      required this.rank,
      required this.rating,
      required this.registrationTimeSeconds,
      required this.titlePhoto,
    });
    
    factory Result.fromJson(Map<String, dynamic> json) {
      return Result(
      contribution: json['contribution'],
      lastOnlineTimeSeconds: json['lastOnlineTimeSeconds'],
      rating: json['rating'],
      friendOfCount: json['friendOfCount'],
      titlePhoto: json['titlePhoto'],
      rank: json['rank'],
      handle: json['handle'],
      maxRating: json['maxRating'],
      avatar: json['avatar'],
      registrationTimeSeconds: json['registrationTimeSeconds'],
      maxRank: json['maxRank'],
      );
    }
}