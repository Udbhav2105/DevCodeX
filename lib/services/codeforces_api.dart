class User {
  final String status;
  final List<Result> result;

  User({required this.status, required this.result});

  factory User.fromJson(Map<String, dynamic> json) {
    var resultList = json['result'] as List;
    List<Result> results = resultList.map((i) => Result.fromJson(i)).toList();
    
    return User(result: results, status: json['status'],);
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