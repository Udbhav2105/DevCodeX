import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CfData {
  Set<String> uniqueOkProblems = {};
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

      cfAuth = true;
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
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
        print(
            'Easy: $easySolved\nMedium: $mediumSolved\nHard: $hardSolved\nExtreme: $extremeSolved\nUnrated: $unratedSolved');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      cfAuth = false;
      print('Exception: $e');
    }
  }
}
