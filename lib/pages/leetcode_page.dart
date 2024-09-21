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
      backgroundColor:Color(0xFF333333),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(100),
          color: Color(0xFF161616),
          child:Text("Hellow how are\nyou doing"),
        ),
      ),
    );
  }
}
