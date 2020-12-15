import 'package:cse310_blog_site/Screens/AuthPages/UserAuthPage.dart';
import 'package:cse310_blog_site/Screens/AuthPages/VerifyEmailScreen.dart';
import 'package:cse310_blog_site/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return HomePage();
      } else {
        return VerifyEmail();
      }
    } else {
      return UserAuthPage();
    }
  }
}
