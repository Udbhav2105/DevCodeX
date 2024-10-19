import 'package:DevCodeX/pages/geeksforgeeks_page.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/pages/leetcode_page.dart';
import 'package:DevCodeX/pages/login.dart';
import 'package:DevCodeX/pages/loading.dart';
import 'package:DevCodeX/pages/home.dart';
import 'package:DevCodeX/pages/codeforces_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:DevCodeX/auth.dart'; // Import your auth.dart
import 'package:DevCodeX/firebase_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user != null) {
              return const Login(); // User is signed in
            } else {
              return FirebaseLogin(); // User is not signed in
            }
          } else {
            return const SpinKitFadingCube(
              color: Colors.white,
              size: 50,
            ); // Waiting for connection state
          }
        },
      ),
      routes: {
        '/home': (context) => Home(),
        '/loading': (context) => const Loading(),
        '/leetcodePage': (context) => LeetcodePage(),
        '/codeforcesPage': (context) => const Codeforces(),
        '/geeksforgeeksPage': (context) => const Geeksforgeeks(),
      },
    );
  }
}
