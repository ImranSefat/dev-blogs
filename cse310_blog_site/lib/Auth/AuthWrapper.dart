import 'package:cse310_blog_site/Screens/SignIn.dart';
import 'package:cse310_blog_site/Timeline.dart';
import 'package:cse310_blog_site/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Timeline(
        firebaseUser: firebaseUser,
      );
    } else {
      return SignIn();
    }
  }
}
