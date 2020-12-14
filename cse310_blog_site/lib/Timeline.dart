import 'package:cse310_blog_site/Service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timeline extends StatefulWidget {
  final User firebaseUser;
  Timeline({this.firebaseUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String desc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.supervised_user_circle),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please fill up";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  desc = value;
                },
                validator: (value) {
                  if (value.length == 0) {
                    return "Please fill up";
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Description"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
                child: Text("Add to Database"),
              ),
            ),
          ],
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
