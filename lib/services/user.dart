class User {
  final String username;
  final String name;
  final String birthday;
  final String avatar;
  final int ranking;
  final int reputation;
  final String gitHub;
  final String twitter;
  final String linkedIN;
  final List<String> websites;
  final String country;
  final String company;
  final String school;
  final List<String> skillTags;
  final String about;
  final double starRating;
  final int contributionsPoints;
  final int contributionsQuestionCount;
  final int contributionsTestcaseCount;

  User({
    required this.username,
    required this.name,
    required this.birthday,
    required this.avatar,
    required this.ranking,
    required this.reputation,
    required this.gitHub,
    required this.twitter,
    required this.linkedIN,
    required this.websites,
    required this.country,
    required this.company,
    required this.school,
    required this.skillTags,
    required this.about,
    required this.starRating,
    required this.contributionsPoints,
    required this.contributionsQuestionCount,
    required this.contributionsTestcaseCount,
  });
}