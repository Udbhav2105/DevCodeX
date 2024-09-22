import 'package:flutter/material.dart';

class AvatarUsername extends StatefulWidget {
  final String user;
  const  AvatarUsername({required this.user,super.key});

  @override
  State< AvatarUsername> createState() => _AvatarUsernameState();
}

class _AvatarUsernameState extends State< AvatarUsername> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.fromLTRB(30, 10, 0, 20),
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(width:30,),
          Text(
            '${widget.user}'.toUpperCase(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
