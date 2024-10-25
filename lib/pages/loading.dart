import 'package:DevCodeX/services/gfg_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:DevCodeX/services/leetcode_api.dart';
import 'package:DevCodeX/services/app_color.dart';

import 'package:DevCodeX/services/cfdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:DevCodeX/services/dcx_user.dart';
import 'package:DevCodeX/auth.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService _auth;
  Map data = {};

  void setUpLeetcodeAndCodeforces(
      String lcUsername, String cfUsername, String gfgUsername) async {
    if (_auth.currentUser == null) return;

    final uid = _auth.currentUser!.uid;
    final dRR = db.collection('users').doc(uid);

    final userDoc = await dRR.get();
    if (!userDoc.exists) {
      final dcxUser = DcxUser(
        cfUsername: cfUsername,
        lcUsername: lcUsername,
        gfgUsername: gfgUsername,
        uid: uid,
      );
    final docRef = db.collection('users').withConverter(
            fromFirestore: DcxUser.fromFirestore,
            toFirestore: (dcxUser, options) => dcxUser.toFirestore(),
          ).doc(uid);
          await docRef.set(dcxUser);
    }

    CfData codeforcesData = CfData(username: cfUsername);
    await codeforcesData.fetchUserStatus();
    await codeforcesData.fetchUserInfo();

    GfgData gfgData = GfgData(userName: gfgUsername);
    await gfgData.authenticate();

    Lc instance = Lc(lcUsername: lcUsername);
    await instance.getEverything();

    print('Lc Auth: ${instance.lcAuth}\nCf Auth ${codeforcesData.cfAuth}\nGfg Auth ${gfgData.gfgAuth}');


    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'cfData': codeforcesData,
        'lcData': instance,
        'gfgData': gfgData,
      });
    }
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _auth = Provider.of<AuthService>(context);
}
@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (arguments != null) {
      // Use arguments passed to this page
      data = arguments;
      setUpLeetcodeAndCodeforces(
          data['lcUsername']!, data['cfUsername']!, data['gfgUsername']!);
    } else if (_auth.currentUser != null) {
      // No arguments, check Firestore for existing data
      final docRef = db.collection('users').doc(_auth.currentUser!.uid);
      final userDoc = await docRef.get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        data = {
          'lcUsername': userData['lcUsername'],
          'cfUsername': userData['cfUsername'],
          'gfgUsername': userData['gfgUsername'],
        };
        setUpLeetcodeAndCodeforces(
            data['lcUsername'], data['cfUsername'], data['gfgUsername']);
      } else {
        // If no data exists in Firestore, navigate to login page
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
