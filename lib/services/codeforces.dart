import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Codeforces extends StatefulWidget {
  const Codeforces({super.key});
  @override
  CodeforcesState createState() => CodeforcesState();
}

class CodeforcesState extends State<Codeforces> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }


  @override
  
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Codeforces')),
        body: Center(
          child: FutureBuilder(future: futureUser, builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final user = snapshot.data!;
              final result = user.result[0];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(result.avatar),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text('${result.handle}'),
                  Text('Rating: ${result.rating}'),
                  Text('Rank: ${result.rank}'),
                  Text('Max Rank: ${result.maxRank}'),
                  Text('Contributions: ${result.contribution}'),
                  Text('Friends: ${result.friendOfCount}'),
                ],
              );
            }
          })
        )
      );
    }
  }
Future<User> fetchUser() async {
  final response = await http.get(Uri.parse('https://codeforces.com/api/user.info?handles=vaibhavveerwaal&checkHistoricHandles=false'));
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
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
