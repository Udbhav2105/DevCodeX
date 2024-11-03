import 'package:DevCodeX/auth.dart';
import 'package:DevCodeX/components/chat_bubble.dart';
import 'package:DevCodeX/components/input_field.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:DevCodeX/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final String receiverId;

  ChatPage({
    super.key,
    required this.receiverId,
  });

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage(BuildContext context) async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          receiverId, _messageController.text, context);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = Provider.of<AuthService>(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Text(receiverId, style: const TextStyle(color: AppColors.secondaryColor)),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(_auth),
            ),
            _buildUserInput(context),
          ],
        ));
  }

  Widget _buildMessageList(AuthService _auth) {
    String senderId = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error occurred'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc, _auth))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, AuthService _auth) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _auth.currentUser!.uid;
    var alignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Text(
        //   data['message'],
        //   style: const TextStyle(color: AppColors.secondaryColor),
        // ),
        ChatBubble(
          isCurrentUser: isCurrentUser,
          message: data['message'],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 35),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              inputText: 'Type a message',
              controller: _messageController,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => sendMessage(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
          )
        ],
      ),
    );
  }
}
