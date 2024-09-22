import 'package:flutter/material.dart';
import 'package:ripoff/services/leetcode_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};
  void setUpLeetcode() async {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    print(data);
    Lc instance = Lc(lcUsername: data['lcUsername']);
    await instance.authenticate();
    if (instance.auth == false) {
      Navigator.pushNamed(context, '/');
    } else {
      await instance.getData();
      // print('Data received ${instance.problemCount}');
      print('received');
    }
    await instance.fetchProblemCount();
    // print('${instance.problemCount.totalAcCount} \n ${instance.problemCount.totalEasySubmittedCount}\n ${instance.problemCount.totalMediumSubmittedCount} \n ${instance.problemCount.totalHardSubmittedCount}');
    Navigator.pushReplacementNamed(context, '/leetcodePage',arguments: {
      'totalProblem' : instance.problemCount.totalAcCount as int?,
      'totalEasyAccepted': instance.problemCount.totalEasySubmittedCount as int?,
      'totalMediumAccepted': instance.problemCount.totalMediumSubmittedCount as int?,
      'totalHardAccepted': instance.problemCount.totalHardSubmittedCount as int?,
      'username': data['lcUsername'],
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      setUpLeetcode();
    });
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Color(0xFF161616),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
