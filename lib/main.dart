import 'package:flutter/material.dart';
import 'package:ripoff/pages/leetcode_page.dart';
import 'package:ripoff/pages/login.dart';
import 'package:ripoff/pages/loading.dart';
import 'package:ripoff/pages/home.dart';

void main() => runApp(MaterialApp(
  // home: LeetcodePage(),
  initialRoute: '/',
  routes: {
    '/':(context) => const Login(),
    '/loading': (context) => const Loading(),
    '/home': (context) => const Home(),
    '/leetcodePage':(context) => LeetcodePage(),
  },
));
