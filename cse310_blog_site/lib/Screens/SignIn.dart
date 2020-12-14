import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  String _email;
  String _pass;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: size.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.length == 0) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (v) {
                      _email = v;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                    onChanged: (v) {
                      _pass = v;
                    },
                    validator: (value) {
                      if (value.length == 0) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        child: Text("Sign In"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context
                                .read<AuthenticationService>()
                                .signIn(_email, _pass);
                          }
                        },
                      ),
                      FlatButton(
                        color: Colors.green,
                        child: Text("Register"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context
                                .read<AuthenticationService>()
                                .signUp(_email, _pass);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
