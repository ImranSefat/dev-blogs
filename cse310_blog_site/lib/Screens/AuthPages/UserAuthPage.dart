import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserAuthPage extends StatefulWidget {
  @override
  _UserAuthPageState createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
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
                      Container(
                        width: size.width / 5,
                        child: Lottie.asset('assets/lottie/login.json'),
                      ),
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
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
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
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
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
                          Container(
                            width: size.width / 9,
                            height: 40,
                            child: FlatButton(
                              color: Colors.blue,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.4,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic response = await context
                                      .read<AuthenticationService>()
                                      .signIn(
                                        _email,
                                        _pass,
                                      );
                                  if (response.toString() != 'success') {
                                    _showMaterialDialog(response.toString());
                                  }
                                }
                              },
                            ),
                          ),
                          Container(
                            width: size.width / 9,
                            height: 40,
                            child: FlatButton(
                              color: Colors.green,
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.4,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic response = await context
                                      .read<AuthenticationService>()
                                      .signUp(
                                        _email,
                                        _pass,
                                      );
                                  if (response.toString() != 'success') {
                                    _showMaterialDialog(response.toString());
                                  }
                                }
                              },
                            ),
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

  _showMaterialDialog(String data) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Alert"),
        content: new Text(data),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
