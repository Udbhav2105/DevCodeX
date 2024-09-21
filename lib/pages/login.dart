import 'package:flutter/material.dart';
import 'package:ripoff/components/input_field.dart';
import 'package:ripoff/services/leetcode.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void data() async{
    print('here');
    lc instance = lc(url: 'Udbhav_k');
     await instance.getData();
     print(instance.userInfo);
     print('here1');

  }
  @override
  void initState() {
    super.initState();
    data();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF161616),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0,100,0,150),
              child: Text(
                'ENTER USERNAME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFf6fed1),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            InputField(inputText: 'Codeforces'),
            SizedBox(
              height: 20,
            ),
            InputField(inputText: 'Leetcode'),
          ],
        ),
      ),
    );
  }
}
