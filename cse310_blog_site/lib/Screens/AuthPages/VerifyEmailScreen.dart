import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool enabled = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer Blogs"),
        actions: [
          FlatButton.icon(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            label: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await context.read<AuthenticationService>().signOut();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Please verify email to access",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            color: Colors.green,
            onPressed: enabled
                ? () async {
                    await FirebaseAuth.instance.currentUser
                        .sendEmailVerification();
                    setState(() {
                      enabled = false;
                    });
                  }
                : null,
            child: Text("Send Email Verification again"),
          ),
        ],
      ),
    );
  }
}
