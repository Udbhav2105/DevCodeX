import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:DevCodeX/auth.dart';
import 'package:DevCodeX/firebase_login.dart';
import 'package:DevCodeX/services/app_color.dart';
import 'package:DevCodeX/pages/login.dart';
import 'package:DevCodeX/pages/loading.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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