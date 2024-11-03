import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DevCodeX/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

Future<List<DocumentSnapshot>> searchFirebaseUsers(BuildContext context, String query) async {
  final _auth = Provider.of<AuthService>(context, listen: false);
  final currentUserId = _auth.currentUser?.uid;

  final results = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isNotEqualTo: currentUserId)
      .where('uid', isEqualTo: query)
      .get();

  return results.docs;
}
