import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SampleViewPost extends StatefulWidget {
  final String title;
  final String description;
  final Timestamp createdAt;
  final String authorEmail;

  SampleViewPost({
    this.title,
    this.description,
    this.createdAt,
    this.authorEmail,
  });
  @override
  _SampleViewPostState createState() => _SampleViewPostState();
}

class _SampleViewPostState extends State<SampleViewPost> {
  String desc =
      "This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string This is a really long string";

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(isDark ? 0.1 : 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(2, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                        letterSpacing: 1.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SelectableText("Written by ${widget.authorEmail}"),
                    ),
                    Text(
                      widget.createdAt.toDate().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Row(
                    //     children: [
                    //       Text("Categories: "),
                    //       FlatButton(
                    //         onPressed: () {},
                    //         child: Text("Flutter"),
                    //       ),
                    //       FlatButton(
                    //         onPressed: () {},
                    //         child: Text("App Development"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Text(
                      widget.description,
                      // desc.substring(0, 480) + "...",
                      textAlign: TextAlign.justify,
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     FaIcon(
                    //       FontAwesomeIcons.solidHeart,
                    //       color: Colors.redAccent,
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text("32 Loves")
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // Flexible(
            //   flex: 1,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //       topRight: Radius.circular(8),
            //       bottomRight: Radius.circular(8),
            //     ),
            //     child: FadeInImage.assetNetwork(
            //       fit: BoxFit.cover,
            //       image:
            //           'https://images.unsplash.com/photo-1480694313141-fce5e697ee25?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
            //       placeholder: 'images/chilling.png',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
