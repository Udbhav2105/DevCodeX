import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FirebaseLogin extends StatelessWidget {
  final AuthService _auth = AuthService();

  FirebaseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                height: 150,
                color: Colors.black12,
                child: const Text(
                  "DevCodeX",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Adding a SizedBox to separate the title from the bottom container
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signInAnonymously();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(200, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Continue without Signing In",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.7,
                                    fontSize: 17),
                              ),
                              Icon(Icons.account_circle),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _auth.signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(200, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sign In with Google",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 0.7,
                                    fontSize: 17),
                              ),
                              FaIcon(FontAwesomeIcons.google),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
