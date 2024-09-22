// import 'dart:convert';
// import 'package:http/http.dart' as http;
class GfgUser {
  final Info info;
  final SolvedStats? solvedStats;

  GfgUser({required this.info, this.solvedStats});

  factory GfgUser.fromJson(Map<String, dynamic> json) {
    return GfgUser(info: Info.fromJson(json['info']),
      solvedStats: SolvedStats.fromJson(json['solvedStats']));
  }
}

class Info {
  final String? userName;
  final String profilePicture;
  final String? instituteRank;
  final String? currentStreak;
  final String? maxStreak;
  final String? institution;
  final String? languagesUsed;
  final String? codingScore;
  final String? totalProblemsSolved;
  final String? monthlyCodingScore;
  final String? articlesPublished;

  Info({this.articlesPublished, this.codingScore, this.currentStreak, this.instituteRank,
    this.institution, this.languagesUsed, this.maxStreak, this.monthlyCodingScore,
    required this.profilePicture, this.totalProblemsSolved, this.userName
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(articlesPublished: json['articlesPublished'],
      codingScore: json['codingScore'], currentStreak: json['currentStreak'], instituteRank: json['instituteRank'],
      institution: json['institution'], languagesUsed: json['languagesUsed'], maxStreak: json['maxStreak'], monthlyCodingScore: json['monthlyCodingScore'],
      profilePicture: json['profilePicture'], totalProblemsSolved: json['totalProblemsSolved'], userName: json['userName'],
    );
  }
}

class SolvedStats {
  final Difficulty school;
  final Difficulty easy;
  final Difficulty medium;
  final Difficulty hard;
  final Difficulty basic;

  SolvedStats({required this.school, required this.easy, required this.hard, required this.medium, required this.basic});

  factory SolvedStats.fromJson(Map<String, dynamic> json) {
    return SolvedStats(school: Difficulty.fromJson(json['school']), easy: Difficulty.fromJson(json['easy']), 
      hard: Difficulty.fromJson(json['hard']), medium: Difficulty.fromJson(json['medium']), basic: Difficulty.fromJson(json['basic'])
    );
  }
}

class Difficulty {
  final int count;
  final List<Questions>? questions;

  Difficulty({required this.count, this.questions});

  factory Difficulty.fromJson(Map<String, dynamic> json) {
    return Difficulty(count: json['count'], 
      questions: List<Questions>.from(
        (json['questions'] as List<dynamic>?)?.map((item) => Questions.fromJson(item)) ?? [],
      )
    );
  }
}

class Questions {
  final String question;
  final String questionUrl;
  
  Questions({required this.question, required this.questionUrl});

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(question: json['question'], questionUrl: json['questionUrl']);
  }
}

// void main() async {
//   const url = 'https://geeks-for-geeks-api.vercel.app/udbhavlamd';
//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       GfgUser gfgUser = GfgUser.fromJson(data);

//       print('Username: ${gfgUser.info?.userName}');
//       print('Coding score: ${gfgUser.info?.codingScore}');
//       print('Institute rank: ${gfgUser.info?.instituteRank}');

//       // Accessing the solved stats
//       print('Solved count (school): ${gfgUser.solvedStats?.school.count}');
//       for (var question in gfgUser.solvedStats?.school.questions ?? []) {
//         print('School Question: ${question.question}');
//         print('School Question URL: ${question.questionUrl}');
//       }

//       print('Solved count (basic): ${gfgUser.solvedStats?.basic.count}');
//       for (var question in gfgUser.solvedStats?.basic.questions ?? []) {
//         print('Basic Question: ${question.question}');
//         print('Basic Question URL: ${question.questionUrl}');
//       }

//       print('Solved count (easy): ${gfgUser.solvedStats?.easy.count}');
//       for (var question in gfgUser.solvedStats?.easy.questions ?? []) {
//         print('Easy Question: ${question.question}');
//         print('Easy Question URL: ${question.questionUrl}');
//       }

//       print('Solved count (medium): ${gfgUser.solvedStats?.medium.count}');
//       for (var question in gfgUser.solvedStats?.medium.questions ?? []) {
//         print('Medium Question: ${question.question}');
//         print('Medium Question URL: ${question.questionUrl}');
//       }

//       print('Solved count (hard): ${gfgUser.solvedStats?.hard.count}');
//       for (var question in gfgUser.solvedStats?.hard.questions ?? []) {
//         print('Hard Question: ${question.question}');
//         print('Hard Question URL: ${question.questionUrl}');
//       }
//     } else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error occurred: $e');
//   }
// }
