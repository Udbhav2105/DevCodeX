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