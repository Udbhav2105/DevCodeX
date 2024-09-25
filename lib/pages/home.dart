import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String,dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    List<Widget> cfOrLc = [];
    if (data['lcData'].lcAuth) {
      cfOrLc.add(
          // whats wrong with ours?
          Container(
              child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/leetcodePage',
              arguments: data);
        },
        icon: Icon(Icons.arrow_forward),
        label: Text("Leetcode"),
      ))); // whats that thing ? on your phone? aint that page?
      cfOrLc.add(SizedBox(
        height: 30,
      ));
    }
    //
    if (data['cfAuth']) {
      cfOrLc.add(SizedBox(
        height: 30,
      ));
      cfOrLc.add(Container(
          child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/codeforcesPage',
              arguments: data);
        },
        icon: Icon(Icons.arrow_forward),
        label: Text("CODEFORCES"),
      )));
    } // yes you may pull
    return Scaffold(
      // backgroundColor: Color(OxFF),
      body: SafeArea(
        child: Column(
          children: [...cfOrLc],
        ),
      ),
    );
  }
}
