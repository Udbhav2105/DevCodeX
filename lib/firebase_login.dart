import 'package:flutter/material.dart';
import 'package:DevCodeX/auth.dart';

class FirebaseLogin extends StatelessWidget {
  final AuthService _auth = AuthService();
  FirebaseLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _auth.signInAnonymously();
              },
              child: const Text('Sign in Anonymously'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signInWithGoogle();
              },
              child: const Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
