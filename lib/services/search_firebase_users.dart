import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> searchFirebaseUsers(String query) async {
  final results = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: query)
      .get();

  return results.docs;
}
