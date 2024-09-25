import 'package:flutter/material.dart';
import 'package:ripoff/components/input_field.dart';
import 'package:ripoff/services/leetcode_api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController cfUsername = TextEditingController();
  final TextEditingController lcUsername = TextEditingController();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   cfUsername.clear();
  //   lcUsername.clear();
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 150),
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
              InputField(inputText: 'Codeforces',controller: cfUsername,),
              const SizedBox(
                height: 20,
              ),
              InputField(inputText: 'Leetcode',controller: lcUsername,),
              const SizedBox(height: 66),
              ElevatedButton.icon(
                onPressed: () {
                  // print(cfUsername.text);
                  if (cfUsername.text.isEmpty  && lcUsername.text.isEmpty){
                    print('Cannot be empty');
                  }else{
                    Navigator.pushNamed(context, '/loading',arguments: {
                      'cfUsername': cfUsername.text,
                      'lcUsername': lcUsername.text
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF161616),
                ),
                label: const Text(
                  "Next",
                  style: TextStyle(
                      color: Color(0xFF161616),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFf6fed1),
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
