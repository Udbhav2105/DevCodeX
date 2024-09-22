import 'package:flutter/material.dart';

class LeetcodePage extends StatefulWidget {
  const LeetcodePage({super.key});

  @override
  State<LeetcodePage> createState() => _LeetcodePageState();
}

class _LeetcodePageState extends State<LeetcodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF161616),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 10, 0, 20),
              child: Row(
                children: [
                  CircleAvatar(),
                  SizedBox(width:30,),
                  Text(
                    'Username'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(150, 100, 150, 100),
            color: Color(0xFF0e0e0e),
            child:Text("Problem Count",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
