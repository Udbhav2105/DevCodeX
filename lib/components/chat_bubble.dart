import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.secondaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          message,
          style: const TextStyle(color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}