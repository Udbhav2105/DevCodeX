import 'package:cloud_firestore/cloud_firestore.dart';

class DcxUser {
  final String uid;
  final String? cfUsername;
  final String? lcUsername;
  final String? gfgUsername;

  DcxUser({
    required this.uid,
    this.cfUsername,
    this.gfgUsername,
    this.lcUsername,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'cfUsername': cfUsername,
  //     'lcUsername': lcUsername,
  //     'gfgUsername': gfgUsername,
  //   };
  // }

  // factory DcxUser.fromMap(Map<String, dynamic> map) {
  //   return DcxUser(
  //       uid: map['uid'],
  //       cfUsername: map['cfUsername'],
  //       lcUsername: map['lcUsername'],
  //       gfgUsername: map['gfgUsername']);
  // }

  factory DcxUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DcxUser(
        uid: data?['uid'],
        cfUsername: data?['cfUsername'],
        lcUsername: data?['lcUsername'],
        gfgUsername: data?['gfgUsername']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      if (cfUsername != null) "cfUsername": cfUsername,
      if (lcUsername != null) "lcUsername": lcUsername,
      if (gfgUsername != null) "gfgUsername": gfgUsername,
    };
  }
}
