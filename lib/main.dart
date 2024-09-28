import 'package:flutter/material.dart';
import 'package:ripoff/pages/leetcode_page.dart';
import 'package:ripoff/pages/login.dart';
import 'package:ripoff/pages/loading.dart';
import 'package:ripoff/pages/home.dart';
import 'package:ripoff/pages/codeforces_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/':(context) => const Login(),
    '/loading': (context) => const Loading(),
    '/home': (context) => const Home(),
    '/leetcodePage':(context) => const LeetcodePage(),
    '/codeforcesPage' :(context) => const Codeforces(),
  },
));
