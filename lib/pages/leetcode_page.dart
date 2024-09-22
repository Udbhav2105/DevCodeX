import 'package:flutter/material.dart';
import 'package:ripoff/components/username_avatar.dart';

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
            child: AvatarUsername(user: 'username',),
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
