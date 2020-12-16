import 'package:flutter/material.dart';

class FlutterPosts extends StatefulWidget {
  @override
  _FlutterPostsState createState() => _FlutterPostsState();
}

class _FlutterPostsState extends State<FlutterPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 700,
          color: Colors.green,
        ),
        Container(
          height: 700,
          color: Colors.red,
        ),
      ],
    );
  }
}
