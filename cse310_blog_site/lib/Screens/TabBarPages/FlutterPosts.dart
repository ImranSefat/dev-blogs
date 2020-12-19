import 'package:cse310_blog_site/Screens/TestWidgets/SampleViewPost.dart';
import 'package:flutter/material.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class FlutterPosts extends StatefulWidget {
  @override
  _FlutterPostsState createState() => _FlutterPostsState();
}

class _FlutterPostsState extends State<FlutterPosts> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SmoothScrollWeb(
      controller: _scrollController,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        children: [
          SampleViewPost(),
          SampleViewPost(),
        ],
      ),
    );
  }
}
