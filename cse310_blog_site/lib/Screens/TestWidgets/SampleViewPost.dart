import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse310_blog_site/Screens/PostDetails.dart';
import 'package:cse310_blog_site/Service/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SampleViewPost extends StatefulWidget {
  final String title;
  final String description;
  final Timestamp createdAt;
  final String authorEmail;
  final int loved;
  final String category;
  final DocumentSnapshot document;

  SampleViewPost({
    this.title,
    this.description,
    this.createdAt,
    this.authorEmail,
    this.loved,
    this.category,
    this.document,
  });
  @override
  _SampleViewPostState createState() => _SampleViewPostState();
}

class _SampleViewPostState extends State<SampleViewPost> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    bool isDark = theme.getTheme() == ThemeData.dark() ? true : false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetils(
                documentSnapshot: widget.document,
              ),
            ),
          );
        },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 32,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    CollectionReference posts =
                                        FirebaseFirestore.instance
                                            .collection('postCollection');
                                    posts.doc(widget.document.id).update({
                                      'loved': widget.loved + 1,
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Loved ${widget.loved} times")
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:
                            SelectableText("Written by ${widget.authorEmail}"),
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
                      // InkWell(
                      //   onDoubleTap: () {
                      //     FlutterClipboard.copy(widget.description);
                      //     _showMaterialDialog(
                      //         "Description has been copied to clipboard");
                      //   },
                      //   child: Text(
                      //     widget.description,
                      //     // desc.substring(0, 480) + "...",
                      //     textAlign: TextAlign.justify,
                      //     style: TextStyle(),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
