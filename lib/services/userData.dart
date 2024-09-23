class UserDataInfo {
  final int? totalProblem;
  final int? totalEasyAccepted;
  final int? totalMediumAccepted;
  final int? totalHardAccepted;
  final String? username;
  final String? avatar;
  final bool? lcAuth;

  UserDataInfo(this.totalProblem, this.totalEasyAccepted, this.totalHardAccepted,
      this.username, this.avatar, this.lcAuth, this.totalMediumAccepted,
      {total});
}
