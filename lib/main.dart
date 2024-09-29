import 'package:DevCodeX/pages/geeksforgeeks_page.dart';
import 'package:flutter/material.dart';
import 'package:DevCodeX/pages/leetcode_page.dart';
import 'package:DevCodeX/pages/login.dart';
import 'package:DevCodeX/pages/loading.dart';
import 'package:DevCodeX/pages/home.dart';
import 'package:DevCodeX/pages/codeforces_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/':(context) => const Login(),
    '/loading': (context) => const Loading(),
    '/home': (context) =>  Home(),
    '/leetcodePage':(context) =>  LeetcodePage(),
    '/codeforcesPage' :(context) => const Codeforces(),
    '/geeksforgeeksPage' :(context) => const Geeksforgeeks(),
  },
));
