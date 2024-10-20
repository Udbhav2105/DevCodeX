import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';

class AvatarUsername extends StatefulWidget {
  final String user;
  final String avatar;
  const  AvatarUsername({required this.user,super.key, required this.avatar});

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
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatar),
          ),
          SizedBox(width:30,),
          Text(
            '${widget.user}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
    );
  }
}
