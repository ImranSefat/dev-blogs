import 'package:cse310_blog_site/Screens/SignIn.dart';
import 'package:cse310_blog_site/Screens/VerifyEmailScreen.dart';
import 'package:cse310_blog_site/Timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return Timeline(
          firebaseUser: firebaseUser,
        );
      } else {
        return VerifyEmail();
      }
    } else {
      return SignIn();
    }
  }
}
