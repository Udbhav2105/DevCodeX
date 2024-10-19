import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/auth.dart';

class FirebaseLogin extends StatelessWidget {
  final AuthService _auth = AuthService();
  FirebaseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signInAnonymously();
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: AppColors.backgroundColor,
              ),
              label: const Text(
                "Continue without signing in",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signInWithGoogle();
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: AppColors.backgroundColor,
              ),
              label: const Text(
                "Sign in with Google",
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
