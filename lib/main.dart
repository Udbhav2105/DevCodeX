import 'package:DevCodeX/pages/compare_cf.dart';
import 'package:DevCodeX/pages/compare_home.dart';
import 'package:DevCodeX/pages/compare_loading.dart';
import 'package:DevCodeX/pages/geeksforgeeks_page.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/pages/leetcode_page.dart';
import 'package:DevCodeX/pages/login.dart';
import 'package:DevCodeX/pages/loading.dart';
import 'package:DevCodeX/pages/home.dart';
import 'package:DevCodeX/pages/codeforces_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:DevCodeX/auth.dart';
import 'package:DevCodeX/pages/auth_wrapper.dart';
import 'package:DevCodeX/pages/user_search_screen.dart';
import 'package:DevCodeX/pages/compare_lc.dart';

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
        '/home': (context) => const Home(),
        '/loading': (context) => const Loading(),
        '/leetcodePage': (context) => const LeetcodePage(),
        '/codeforcesPage': (context) => const Codeforces(),
        '/geeksforgeeksPage': (context) => const Geeksforgeeks(),
        '/userSearchScreen': (context) => const UserSearchScreen(),
        '/compareHome': (context) => const CompareHome(),
        '/compareLeetcode': (context) => const CompareLeetcode(),
        '/compareLoading': (context) => const CompareLoading(),
        '/compareCf': (context) => const CompareCf(),
      },
    );
  }
}
