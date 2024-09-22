import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ripoff/services/codeforces_api.dart';

class Codeforces extends StatefulWidget {
  const Codeforces({super.key});
  @override
  CodeforcesState createState() => CodeforcesState();
}

class CodeforcesState extends State<Codeforces> {
  late Future<UnifiedApiResponse> futureUser;
  late Future<UnifiedApiResponse> futureUser2;

  @override
  void initState() {
    super.initState();
    String urlStatus = 'https://codeforces.com/api/user.status?handle=vaibhavveerwaal';
    String urlInfo = 'https://codeforces.com/api/user.info?handles=vaibhavveerwaal&checkHistoricHandles=false';
    futureUser = fetchData(urlInfo,'userInfo');
    futureUser2 = fetchData(urlStatus, 'userStatus');
  }


  @override
  
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Codeforces')),
        body: Center(
          child: FutureBuilder(future: Future.wait([futureUser, futureUser2]), builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userInfo = snapshot.data![0];
              final userStatus = snapshot.data![1];
              final result = userInfo.result[0];
              Set<String> uniqueOkProblems = {};
              int easySolved = 0;
              int mediumSolved = 0;
              int hardSolved = 0;
              int extremeSolved = 0;
              int totalSolved = 0;
              int unratedSolved = 0;

              for (var result in userStatus.result) {
                int? rating = result.problem.rating;
                if (result.verdict == Verdict.OK) {
                  if (!uniqueOkProblems.contains(result.problem.name)) {
                    uniqueOkProblems.add(result.problem.name);
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
              totalSolved = uniqueOkProblems.length;
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(result.avatar),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Text('${result.handle}'),
                  Text('Rating: ${result.rating}'),
                  Text('Rank: ${result.rank}'),
                  Text('Max Rank: ${result.maxRank}'),
                  Text('Contributions: ${result.contribution}'),
                  Text('Friends: ${result.friendOfCount}'),
                  const SizedBox(height: 20,),
                  _buildStatsCard('Total', totalSolved),
                  _buildStatsCard('Easy (800-1300)', easySolved),
                  _buildStatsCard('Medium (1301-1900)', mediumSolved),
                  _buildStatsCard('Hard (1901 - 2600)', hardSolved),
                  _buildStatsCard('Extreme (2601 - 3500)', extremeSolved),
                  _buildStatsCard('Unrated', unratedSolved),
                ],
              );
            }
          })
        )
      );
    }
  }
Future<UnifiedApiResponse> fetchData(String url, String apiType) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return UnifiedApiResponse.fromJson(json.decode(response.body), apiType);
  } else {
    throw Exception('Failed to load data');
  }
}

Widget _buildStatsCard(String title, int count) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          Text(count.toString(), style: const TextStyle(fontSize: 18)),
        ],
      )
    )
  );
}