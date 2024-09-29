import 'dart:convert';
import 'package:http/http.dart' as http;

class GfgData {
  String userName;
  String avatar;
  int totalProblemsSolved;
  int school;
  int basic;
  int easy;
  int medium;
  int hard;
  String institution;
  String languagesUsed;
  int codingScore;
  int instituteRank;
  int currentStreak;
  int articlesPublished;
  bool gfgAuth;

  GfgData({required this.userName})
      : avatar = "https://media.geeksforgeeks.org/img-practice/user_web-1598433228.svg",
        totalProblemsSolved = 0,
        school = 0,
        basic = 0,
        easy = 0,
        medium = 0,
        hard = 0,
        institution = "",
        languagesUsed = "",
        codingScore = 0,
        instituteRank = 0,
        currentStreak = 0,
        articlesPublished = 0,
        gfgAuth = false;

  Future<void> authenticate() async {
    try {
      final response = await http.get(Uri.parse('https://geeks-for-geeks-api.vercel.app/$userName'));

      if (response.statusCode == 200) {
        gfgAuth = true;
        dynamic data = jsonDecode(response.body);

        userName = data['info']['userName'] ?? userName;
        avatar = data['info']['profilePicture'] ?? avatar;
        totalProblemsSolved = int.tryParse(data['info']['totalProblemsSolved']?.toString() ?? "0") ?? 0;
        
        school = data['solvedStats']['school']?['count'] ?? 0;
        basic = data['solvedStats']['basic']?['count'] ?? 0;
        hard = data['solvedStats']['hard']?['count'] ?? 0;
        easy = data['solvedStats']['easy']?['count'] ?? 0;
        medium = data['solvedStats']['medium']?['count'] ?? 0;
        
        institution = data['info']['institution'] ?? "";
        languagesUsed = data['info']['languagesUsed'] ?? "";
        codingScore = int.tryParse(data['info']['codingScore']?.toString() ?? "0") ?? 0;
        instituteRank = int.tryParse(data['info']['instituteRank']?.toString() ?? "0") ?? 0;
        currentStreak = int.tryParse(data['info']['currentStreak']?.toString() ?? "0") ?? 0;
        articlesPublished = int.tryParse(data['info']['articlesPublished']?.toString() ?? "0") ?? 0;

      } else {
        gfgAuth = false;
        print('Error in GFG API: ${response.statusCode}');
      }
    } catch (e) {
      gfgAuth = false;
      print('Exception in GFG API: $e');
    }
  }
}