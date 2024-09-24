import 'package:flutter/material.dart';
import 'package:ripoff/pages/leetcode_page.dart';
import 'package:ripoff/pages/login.dart';
import 'package:ripoff/pages/loading.dart';
import 'package:ripoff/pages/home.dart';
import 'package:ripoff/pages/codeforces_page.dart';

import 'package:ripoff/pages/choice.dart';
void main() => runApp(MaterialApp(
  // home: Choice(); correct user id?
  initialRoute: '/',
  routes: {
    '/':(context) => const Login(),
    '/loading': (context) => const Loading(),
    '/home': (context) => const Home(),
    '/leetcodePage':(context) => LeetcodePage(),
    '/codeforcesPage' :(context) =>Codeforces(),
  },
));
