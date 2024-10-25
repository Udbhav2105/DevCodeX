import 'package:DevCodeX/pages/geeksforgeeks_page.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/pages/leetcode_page.dart';
import 'package:DevCodeX/pages/login.dart';
import 'package:DevCodeX/pages/loading.dart';
import 'package:DevCodeX/pages/home.dart';
import 'package:DevCodeX/pages/codeforces_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:DevCodeX/auth.dart';
import 'package:DevCodeX/firebase_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const Login(),
        '/home': (context) => Home(),
        '/loading': (context) => const Loading(),
        '/leetcodePage': (context) => LeetcodePage(),
        '/codeforcesPage': (context) => const Codeforces(),
        '/geeksforgeeksPage': (context) => const Geeksforgeeks(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Provider.of<AuthService>(context).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
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
                
                if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  var userData = userSnapshot.data!.data() as Map<String, dynamic>;
                  if (userData.containsKey('cfUsername') ||
                      userData.containsKey('lcUsername') ||
                      userData.containsKey('gfgUsername')) {
                    return const Loading();
                  }
                }
                return const Login();
              },
            );
          }
          return FirebaseLogin();
        }
        return const Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 50,
            ),
          ),
        );
      },
    );
  }
}