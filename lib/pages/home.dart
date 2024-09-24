import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map;
    List<Widget> cfOrLc = [];
    if (data['cfAuth']) {
      cfOrLc.add(
          Container(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/leecodePage',arguments: data);
                },
                icon: Icon(Icons.arrow_forward),
                label: Text("CODEFORCES"),
              ))
      );
      cfOrLc.add(SizedBox(height: 30,));
          }
          if (data['lcAuth'])
      {
        cfOrLc.add(SizedBox(height: 30,));
        cfOrLc.add(
            Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Codeforce',arguments: data);
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("CODEFORCES"),
                ))
        );
      }
      return Scaffold(
        body: Column(
          children: [
            ...cfOrLc
          ],
        ),
      );
    }
}
