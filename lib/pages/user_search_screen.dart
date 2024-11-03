import 'package:DevCodeX/services/app_color.dart';
import 'package:DevCodeX/services/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DevCodeX/services/search_firebase_users.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  // String _searchQuery = '';
  List<DocumentSnapshot> _results = [];

  void _onSearchChanged(String query) async {
    print('Search query: $query');
    setState(() {
      // _searchQuery = query;
    });
    if (query.isNotEmpty) {
      final results = await searchFirebaseUsers(context, query);
      setState(() {
        _results = results;
      });
    } else {
      setState(() {
        _results = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: AppColors.secondaryColor),
              labelText: 'Search by uid',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              ),
            ),
            style: const TextStyle(color: AppColors.secondaryColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final userDoc = _results[index];
                return ListTile(
                  title: Text(userDoc['uid'],
                      style: const TextStyle(color: AppColors.secondaryColor)),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          print(userDoc['uid']);
                          print(userDoc['cfUsername']);
                          print('type: ${userDoc['cfUsername'].runtimeType}');
                          Navigator.pushReplacementNamed(context, '/compareLoading', arguments: {
                            'user2': userDoc['uid'],
                          });
                        },
                        icon: const Icon(
                          Icons.compare_arrows,
                          color: AppColors.backgroundColor,
                        ),
                        label: const Text(
                          "Compare",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(receiverId: userDoc['uid'])));
                        },
                        icon: const Icon(
                          Icons.chat,
                          color: AppColors.backgroundColor,
                        ),
                        label: const Text(
                          "Chat",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
