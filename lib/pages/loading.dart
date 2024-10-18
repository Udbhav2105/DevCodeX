import 'package:DevCodeX/services/gfg_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:DevCodeX/services/leetcode_api.dart';
import 'package:DevCodeX/services/app_color.dart';

import 'package:DevCodeX/services/cfdata.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};
  // Function to fetch Codeforces data using the provided username
  void setUpLeetcodeAndCodeforces() async {
    // Fetch the passed data from previous screen (Leetcode and Codeforces usernames)
    data = ModalRoute.of(context)?.settings.arguments as Map;
    String lcUsername = data['lcUsername'];
    String cfUsername = data['cfUsername']; // Get the Codeforces username
    String gfgUsername = data['gfgUsername'];

    // Fetch Codeforces data
    // Map<String, int> codeforcesData = await fetchCodeforcesData(cfUsername);
    CfData codeforcesData = CfData(username: cfUsername);
    await codeforcesData.fetchUserStatus();
    await codeforcesData.fetchUserInfo();


    // Fetch GFG data
    GfgData gfgData = GfgData(userName: gfgUsername);
    await gfgData.authenticate();

    // Fetch Leetcode data
    Lc instance = Lc(lcUsername: lcUsername);

      await instance.getEverything();
    print('Lc Auth: ${instance.lcAuth}\nCf Auth ${codeforcesData.cfAuth}\nGfg auth ${gfgData.gfgAuth}');


    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'cfData': codeforcesData,
      'lcData': instance,
      'gfgData': gfgData,
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setUpLeetcodeAndCodeforces();
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

