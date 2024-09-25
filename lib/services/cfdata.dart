import 'dart:convert';
import 'package:http/http.dart' as http;

class CfData {
  Set<String> uniqueOkProblems = {};
  int maxRating = 0;
  int userRating = 0;
  String avatar = "https://userpic.codeforces.org/no-avatar.jpg";
  String rank = "newbie";
  String maxRank = "newbie";
  int easySolved = 0;
  int mediumSolved = 0;
  int hardSolved = 0;
  int extremeSolved = 0;
  int unratedSolved = 0;
  late String username;
  bool cfAuth = false;


  CfData({required this.username});

  Future<void> fetchUserStatus() async {
    try {
      final response = await http.get(Uri.parse(
          'https://codeforces.com/api/user.status?handle=$username'));
      if (response.statusCode == 200) {
        cfAuth = true;
        dynamic data = jsonDecode(response.body);
        if (data['status'] == "OK") {
          for (var result in data['result']) {
            int? rating = result['problem']['rating'];
            if (result['verdict'] == "OK") {
              if (!uniqueOkProblems.contains(result['problem']['name'])) {
                uniqueOkProblems.add(result['problem']['name']);
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
                } else {
                  unratedSolved++;
                }
              }
            }
          }
        } else {
          cfAuth = false;
          print('CF Status: ${data['status']}');
        }
        print(
            'Easy: $easySolved\nMedium: $mediumSolved\nHard: $hardSolved\nExtreme: $extremeSolved\nUnrated: $unratedSolved');
      } else {
        cfAuth = false;
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      cfAuth = false;
      print('Exception: $e');
    }
  }
  Future<void> fetchUserInfo() async {
    try {
      final response = await http.get(Uri.parse('https://codeforces.com/api/user.info?handles=$username&checkHistoricHandles=false'));
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        if (data['status'] == "OK") {
          cfAuth = true;
          for (var result in data['result']) {
            userRating = result['rating'];
            avatar = result['avatar'];
            rank = result['rank'];
            maxRating = result['maxRating'];
            maxRank = result['maxRank'];
          }
        }
      } else {
        cfAuth = false;
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      cfAuth = false;
      print('Exception: $e');
    }
  }

}
