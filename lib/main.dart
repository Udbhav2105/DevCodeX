import 'package:flutter/material.dart';
import 'package:ripoff/pages/login.dart';
import 'package:ripoff/pages/loading.dart';
import 'package:ripoff/pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Login(),
    '/loading': (context) => Loading(),
    '/home': (context) => Home()
  },
));
