import 'package:DevCodeX/auth.dart';
import 'package:DevCodeX/services/cfdata.dart';
import 'package:DevCodeX/services/gfg_data.dart';
import 'package:DevCodeX/services/leetcode_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CompareLoading extends StatefulWidget {
  const CompareLoading({super.key});

  @override
  CompareLoadingState createState() => CompareLoadingState();
}

class CompareLoadingState extends State<CompareLoading> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthService _auth;
  Map data = {};

  void setUpData(String cfUsername1, String lcUsername1, String gfgUsername1,
      String cfUsername2, String lcUsername2, String gfgUsername2) async {
    CfData cfUser1 = CfData(username: cfUsername1);
    await cfUser1.fetchUserStatus();
    await cfUser1.fetchUserInfo();

    GfgData gfgUser1 = GfgData(userName: gfgUsername1);
    await gfgUser1.authenticate();

    Lc lcUser1 = Lc(lcUsername: lcUsername1);
    await lcUser1.getEverything();

    CfData cfUser2 = CfData(username: cfUsername2);
    await cfUser2.fetchUserStatus();
    await cfUser2.fetchUserInfo();

    GfgData gfgUser2 = GfgData(userName: gfgUsername2);
    await gfgUser2.authenticate();

    Lc lcUser2 = Lc(lcUsername: lcUsername2);
    await lcUser2.getEverything();

    print(
        'Lc Auth1: ${lcUser1.lcAuth}\nCf Auth1 ${cfUser1.cfAuth}\nGfg Auth1 ${gfgUser1.gfgAuth}');
    print(
        'Lc Auth2: ${lcUser2.lcAuth}\nCf Auth2 ${cfUser2.cfAuth}\nGfg Auth2 ${gfgUser2.gfgAuth}');

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/compareHome', arguments: {
        'cfDataUser1': cfUser1,
        'cfDataUser2': cfUser2,
        'lcDataUser1': lcUser1,
        'lcDataUser2': lcUser2,
        'gfgDataUser1': gfgUser1,
        'gfgDataUser2': gfgUser2
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
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      final user1 = _auth.currentUser;
      final user2 = arguments['user2'];

      final docRef = db.collection('users').doc(user1!.uid);
      final userDoc = await docRef.get();

      final user1Data = userDoc.data() as Map<String, dynamic>;
      final docRef2 = db.collection('users').doc(user2);

      final userDoc2 = await docRef2.get();
      final user2Data = userDoc2.data() as Map<String, dynamic>;

      final cfUsername1 = user1Data['cfUsername'];
      final lcUsername1 = user1Data['lcUsername'];
      final gfgUsername1 = user1Data['gfgUsername'];

      final cfUsername2 = user2Data['cfUsername'];
      final lcUsername2 = user2Data['lcUsername'];
      final gfgUsername2 = user2Data['gfgUsername'];

      setUpData(cfUsername1, lcUsername1, gfgUsername1, cfUsername2,
          lcUsername2, gfgUsername2);
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
