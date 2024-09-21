import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'codeforces_api.dart';


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