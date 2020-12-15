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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dev Blogs",
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                fit: BoxFit.cover,
                image: AssetImage('images/img3.jpg'),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: size.width / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value.length == 0) {
                            return "Please enter email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.white,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (v) {
                          _email = v;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
                      SizedBox(
                        height: 20,
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
        ),
      ),
    );
  }
}
